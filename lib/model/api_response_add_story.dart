import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_add_story.g.dart';

part 'api_response_add_story.freezed.dart';

@freezed

class ApiResponseAddStoryModel with _$ApiResponseAddStoryModel {
  const factory ApiResponseAddStoryModel({
    required bool error,
    String? message,
  }) = _ApiResponseAddStoryModel;

  factory ApiResponseAddStoryModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseAddStoryModelFromJson(json);
}
