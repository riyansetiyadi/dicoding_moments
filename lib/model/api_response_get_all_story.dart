import 'package:dicoding_moments/model/story.dart';

class ApiResponseGetAllStoryModel {
  final bool error;
  final String message;
  final List<StoryModel> listStory;

  ApiResponseGetAllStoryModel({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory ApiResponseGetAllStoryModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseGetAllStoryModel(
        error: json["error"],
        message: json["message"],
        listStory: List<StoryModel>.from(
            json["listStory"].map((x) => StoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };
}
