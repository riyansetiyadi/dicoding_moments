import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_moments/api/api_service.dart';
import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/model/story.dart';
import 'package:dicoding_moments/provider/detail_story_provider.dart';
import 'package:dicoding_moments/utils/datetime_helper.dart';
import 'package:dicoding_moments/utils/placemark_helper.dart';
import 'package:dicoding_moments/widgets/handle_error_refresh_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:geocoding/geocoding.dart' as geo;

class StoryDetailsScreen extends StatefulWidget {
  final String storyId;
  final Function(LatLng?) onMapScreen;
  final Function() onBack;

  const StoryDetailsScreen({
    Key? key,
    required this.storyId,
    required this.onMapScreen,
    required this.onBack,
  }) : super(key: key);

  @override
  State<StoryDetailsScreen> createState() => _StoryDetailsScreenState();
}

class _StoryDetailsScreenState extends State<StoryDetailsScreen> {
  LatLng? storyPosition;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailStoryProvider>(
      create: (context) => DetailStoryProvider(
        authRepository: AuthRepository(),
        apiService: ApiService(),
        idStory: widget.storyId,
      ),
      child: Consumer<DetailStoryProvider>(
        builder: (context, state, _) {
          return state.state.map(
            initial: (value) {
              return ErrorRefresh(
                errorTitle: state.message,
                refreshTitle: 'Refresh',
                onPressed: () async {
                  await state.refreshStory();
                },
              );
            },
            loading: (value) {
              return Center(
                child: defaultTargetPlatform == TargetPlatform.iOS
                    ? const CupertinoActivityIndicator(
                        radius: 20.0,
                      )
                    : const CircularProgressIndicator(),
              );
            },
            loaded: (value) {
              StoryModel story = value.data!;
              return Scaffold(
                appBar: AppBar(
                  title: Text(story.name),
                  leading: const Icon(Icons.account_circle),
                  actions: [
                    IconButton(
                      onPressed: () => widget.onBack(),
                      icon: const Icon(Icons.close_rounded),
                    )
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    await state.refreshStory();
                  },
                  child: ListView(
                    children: [
                      CachedNetworkImage(
                        cacheKey: story.photoUrl,
                        imageUrl: story.photoUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: MediaQuery.of(context).size.width,
                        cacheManager: CacheManager(
                          Config(
                            story.photoUrl,
                            stalePeriod: const Duration(days: 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ReadMoreText(
                          story.description,
                          preDataText: story.name,
                          preDataTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          trimLines: 3,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      if (story.lat != null && story.lon != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: FutureBuilder(
                            future: geo.placemarkFromCoordinates(
                              story.lat!,
                              story.lon!,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Error: ${snapshot.error}',
                                );
                              } else {
                                geo.Placemark placemark = snapshot.data![0];
                                String? loc =
                                    PlacemarkHelper().getLocation(placemark);
                                return ListTile(
                                  leading: const Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                  ),
                                  title: (loc == null)
                                      ? null
                                      : Text(
                                          loc,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                  onTap: () {
                                    widget.onMapScreen(
                                      LatLng(
                                        story.lat!,
                                        story.lon!,
                                      ),
                                    );
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 0,
                                );
                              }
                            },
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text(
                          DateTimeHelper().getTimeDifference(
                            story.createdAt ?? DateTime.now(),
                            context,
                          ),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (value) {
              return ErrorRefresh(
                errorTitle: value.message,
                refreshTitle: 'Refresh',
                onPressed: () async {
                  await state.refreshStory();
                },
              );
            },
          );
        },
      ),
    );
  }
}
