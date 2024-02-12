import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_moments/common.dart';
import 'package:dicoding_moments/model/story.dart';
import 'package:dicoding_moments/provider/list_story_provider.dart';
import 'package:dicoding_moments/utils/datetime_helper.dart';
import 'package:dicoding_moments/utils/result_state.dart';
import 'package:dicoding_moments/widgets/handle_error_refresh_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class StoryListScreen extends StatefulWidget {
  final Function(String) onTapped;

  const StoryListScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  State<StoryListScreen> createState() => _StoryListScreenState();
}

class _StoryListScreenState extends State<StoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ListStoryProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: defaultTargetPlatform == TargetPlatform.iOS
                    ? const CupertinoActivityIndicator(
                        radius: 20.0,
                      )
                    : const CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              List<StoryModel> stories = state.storyList;
              return RefreshIndicator(
                onRefresh: () async {
                  await state.refreshStories();
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text(
                        AppLocalizations.of(context)?.titleAppBar ??
                            "Dicoding Moments",
                      ),
                      floating: true,
                      snap: true,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          StoryModel story = stories[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.account_circle,
                                    ),
                                  ),
                                  Text(
                                    story.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => widget.onTapped(story.id),
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
                        childCount: stories.length,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.state == ResultState.noData) {
              return ErrorRefresh(
                errorTitle: state.message,
                refreshTitle: 'Refresh',
                onPressed: () async {
                  await state.refreshStories();
                },
              );
            } else if (state.state == ResultState.error) {
              return ErrorRefresh(
                errorTitle: state.message,
                refreshTitle: 'Refresh',
                onPressed: () async {
                  await state.refreshStories();
                },
              );
            } else {
              return ErrorRefresh(
                errorTitle: state.message,
                refreshTitle: 'Refresh',
                onPressed: () async {
                  await state.refreshStories();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
