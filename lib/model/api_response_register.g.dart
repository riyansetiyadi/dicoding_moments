// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseRegisterModelImpl _$$ApiResponseRegisterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiResponseRegisterModelImpl(
      error: json['error'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ApiResponseRegisterModelImplToJson(
        _$ApiResponseRegisterModelImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
