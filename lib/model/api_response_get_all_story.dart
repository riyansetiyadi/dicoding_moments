import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dicoding_moments/model/story.dart';

part 'api_response_get_all_story.g.dart';

part 'api_response_get_all_story.freezed.dart';

@freezed

class ApiResponseGetAllStoryModel with _$ApiResponseGetAllStoryModel {
      const factory ApiResponseGetAllStoryModel({
    required bool error,
    required String message,
    required List<StoryModel> listStory,
  }) = _ApiResponseGetAllStoryModel;

  factory ApiResponseGetAllStoryModel.fromJson(Map<String, dynamic> json) => _$ApiResponseGetAllStoryModelFromJson(json);
}
