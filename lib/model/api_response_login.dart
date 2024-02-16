import 'package:dicoding_moments/model/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_login.g.dart';

part 'api_response_login.freezed.dart';

@freezed

class ApiResponseLoginModel with _$ApiResponseLoginModel {
  const factory ApiResponseLoginModel({
    required bool error,
    required String message,
    ProfileModel? loginResult,
  }) = _ApiResponseLoginModel;

  factory ApiResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseLoginModelFromJson(json);
}
