class ApiResponseRegisterModel {
  final bool error;
  final String? message;

  ApiResponseRegisterModel({
    required this.error,
    this.message,
  });

  factory ApiResponseRegisterModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseRegisterModel(
        error: json["error"],
        message: json.containsKey('message') ? json["message"] : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
