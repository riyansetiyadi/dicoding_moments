// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_detail_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseGetDetailStoryModelImpl
    _$$ApiResponseGetDetailStoryModelImplFromJson(Map<String, dynamic> json) =>
        _$ApiResponseGetDetailStoryModelImpl(
          error: json['error'] as bool,
          message: json['message'] as String,
          story: StoryModel.fromJson(json['story'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ApiResponseGetDetailStoryModelImplToJson(
        _$ApiResponseGetDetailStoryModelImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
