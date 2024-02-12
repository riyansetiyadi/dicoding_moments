import 'package:dicoding_moments/model/profile.dart';

class ApiResponseLoginModel {
  final bool error;
  final String message;
  final ProfileModel? loginResult;

  ApiResponseLoginModel({
    required this.error,
    required this.message,
    this.loginResult,
  });

  factory ApiResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseLoginModel(
        error: json["error"],
        message: json["message"],
        loginResult: json.containsKey("loginResult")
            ? ProfileModel.fromJson(json["loginResult"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "loginResult": loginResult?.toJson(),
      };
}
