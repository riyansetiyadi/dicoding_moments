import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_register.g.dart';

part 'api_response_register.freezed.dart';

@freezed

class ApiResponseRegisterModel with _$ApiResponseRegisterModel {
  const factory ApiResponseRegisterModel({
    required bool error,
    String? message,
  }) = _ApiResponseRegisterModel;

  factory ApiResponseRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseRegisterModelFromJson(json);
}
