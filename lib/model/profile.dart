import 'dart:convert';

class ProfileModel {
  final String userId;
  final String name;
  final String token;

  ProfileModel({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  factory ProfileModel.fromStringJson(String jsonString) =>
      ProfileModel.fromJson(json.decode(jsonString));

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "token": token,
      };

  String toStringJson() => json.encode(toJson());
}
