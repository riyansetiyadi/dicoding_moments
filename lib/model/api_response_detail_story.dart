import 'package:dicoding_moments/model/story.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_detail_story.g.dart';

part 'api_response_detail_story.freezed.dart';

@freezed

class ApiResponseGetDetailStoryModel with _$ApiResponseGetDetailStoryModel {
  const factory ApiResponseGetDetailStoryModel({
    required bool error,
    required String message,
    required StoryModel story,
  }) = _ApiResponseGetDetailStoryModel;

  factory ApiResponseGetDetailStoryModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseGetDetailStoryModelFromJson(json);
}
