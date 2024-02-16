import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_moments/common.dart';
import 'package:dicoding_moments/model/story.dart';
import 'package:dicoding_moments/provider/list_story_provider.dart';
import 'package:dicoding_moments/utils/datetime_helper.dart';
import 'package:dicoding_moments/utils/placemark_helper.dart';
import 'package:dicoding_moments/widgets/handle_error_refresh_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geo;

class StoryListScreen extends StatefulWidget {
  final Function(String) onDetailScreen;
  final ScrollController scrollController;

  const StoryListScreen({
    Key? key,
    required this.onDetailScreen,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<StoryListScreen> createState() => _StoryListScreenState();
}

class _StoryListScreenState extends State<StoryListScreen> {
  @override
  void initState() {
    super.initState();
    final listStoryProvider = context.read<ListStoryProvider>();

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels >=
          widget.scrollController.position.maxScrollExtent) {
        if (listStoryProvider.pageItems != null) {
          listStoryProvider.infiniteScrollState.map(
            initial: (value) {
              return listStoryProvider.fetchStory();
            },
            loading: (value) {
              return;
            },
            loaded: (value) {
              return listStoryProvider.fetchStory();
            },
            error: (value) {
              return;
            },
          );
        }
      }
    });

    Future.microtask(() async => listStoryProvider.fetchStory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ListStoryProvider>(
          builder: (context, state, _) {
            return state.state.map(
              initial: (value) {
                return ErrorRefresh(
                  errorTitle: state.message,
                  refreshTitle: 'Refresh',
                  onPressed: () async {
                    await state.refreshStories();
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
                List<StoryModel> stories = value.data;
                return CustomScrollView(
                  controller: widget.scrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text(
                        AppLocalizations.of(context)?.titleAppBar ??
                            "Dicoding Moments",
                      ),
                      floating: true,
                      snap: true,
                    ),
                    CupertinoSliverRefreshControl(
                      onRefresh: () async {
                        await state.refreshStories();
                      },
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index == stories.length &&
                              state.pageItems != null) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          StoryModel story = stories[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (story.lat != null && story.lon != null)
                                  ? FutureBuilder(
                                      future: geo.placemarkFromCoordinates(
                                        story.lat!,
                                        story.lon!,
                                      ),
                                      builder: (context, snapshot) {
                                        geo.Placemark? placemark =
                                            snapshot.data?[0];
                                        String? loc = PlacemarkHelper()
                                            .getLocation(placemark);
                                        if (loc == null) {
                                          return headingPostWithoutSubtitle(
                                            story,
                                          );
                                        } else {
                                          return headingPostWithSubtitle(
                                            story,
                                            loc,
                                          );
                                        }
                                      })
                                  : headingPostWithoutSubtitle(story),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => widget.onDetailScreen(story.id),
                                  child: CachedNetworkImage(
                                    cacheKey: story.photoUrl,
                                    imageUrl: story.photoUrl,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            SizedBox(
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
                                    height: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    cacheManager: CacheManager(
                                      Config(
                                        story.photoUrl,
                                        stalePeriod: const Duration(days: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
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
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                        childCount:
                            stories.length + (state.pageItems != null ? 1 : 0),
                      ),
                    ),
                  ],
                );
              },
              error: (value) {
                return ErrorRefresh(
                  errorTitle: value.message,
                  refreshTitle: 'Refresh',
                  onPressed: () async {
                    await state.refreshStories();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  ListTile headingPostWithoutSubtitle(StoryModel story) {
    return ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.account_circle,
        ),
      ),
      title: Text(
        story.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
    );
  }

  ListTile headingPostWithSubtitle(StoryModel story, String subtitleText) {
    return ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.account_circle,
        ),
      ),
      title: Text(
        story.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitleText,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
    );
  }
}
