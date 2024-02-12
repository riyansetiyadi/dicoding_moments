import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_moments/api/api_service.dart';
import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/model/story.dart';
import 'package:dicoding_moments/provider/detail_story_provider.dart';
import 'package:dicoding_moments/utils/datetime_helper.dart';
import 'package:dicoding_moments/utils/result_state.dart';
import 'package:dicoding_moments/widgets/handle_error_refresh_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class StoryDetailsScreen extends StatefulWidget {
  final String storyId;

  const StoryDetailsScreen({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  State<StoryDetailsScreen> createState() => _StoryDetailsScreenState();
}

class _StoryDetailsScreenState extends State<StoryDetailsScreen> {
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
          StoryModel? story = state.story;
          if (state.state == ResultState.loading) {
            return Center(
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? const CupertinoActivityIndicator(
                      radius: 20.0,
                    )
                  : const CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(story?.name ?? ''),
                leading: const Icon(Icons.account_circle),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  )
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await state.refreshStory();
                },
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      cacheKey: story?.photoUrl,
                      imageUrl: story?.photoUrl ?? '',
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
                          story?.photoUrl ?? '',
                          stalePeriod: const Duration(days: 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ReadMoreText(
                        story?.description ?? '',
                        preDataText: story?.name,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Text(
                        DateTimeHelper().getTimeDifference(
                          story?.createdAt ?? DateTime.now(),
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
          } else if (state.state == ResultState.noData) {
            return ErrorRefresh(
              errorTitle: state.message,
              refreshTitle: 'Refresh',
              onPressed: () async {
                await state.refreshStory();
              },
            );
          } else if (state.state == ResultState.error) {
            return ErrorRefresh(
              errorTitle: state.message,
              refreshTitle: 'Refresh',
              onPressed: () async {
                await state.refreshStory();
              },
            );
          } else {
            return ErrorRefresh(
              errorTitle: state.message,
              refreshTitle: 'Refresh',
              onPressed: () async {
                await state.refreshStory();
              },
            );
          }
        },
      ),
    );
  }
}
