// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseLoginModelImpl _$$ApiResponseLoginModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiResponseLoginModelImpl(
      error: json['error'] as bool,
      message: json['message'] as String,
      loginResult: json['loginResult'] == null
          ? null
          : ProfileModel.fromJson(json['loginResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ApiResponseLoginModelImplToJson(
        _$ApiResponseLoginModelImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'loginResult': instance.loginResult,
    };
