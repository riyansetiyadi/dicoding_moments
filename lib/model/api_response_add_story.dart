class ApiResponseAddStoryModel {
  final bool error;
  final String? message;

  ApiResponseAddStoryModel({
    required this.error,
    this.message,
  });

  factory ApiResponseAddStoryModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseAddStoryModel(
        error: json["error"],
        message: json.containsKey('message') ? json["message"] : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
