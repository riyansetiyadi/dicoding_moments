import 'package:dicoding_moments/model/story.dart';

class ApiResponseGetDetailStoryModel {
  final bool error;
  final String message;
  final StoryModel story;

  ApiResponseGetDetailStoryModel({
    required this.error,
    required this.message,
    required this.story,
  });

  factory ApiResponseGetDetailStoryModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseGetDetailStoryModel(
        error: json["error"],
        message: json["message"],
        story: StoryModel.fromJson(json["story"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story.toJson(),
      };
}
