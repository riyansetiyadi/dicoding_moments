// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_get_all_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseGetAllStoryModelImpl _$$ApiResponseGetAllStoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiResponseGetAllStoryModelImpl(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ApiResponseGetAllStoryModelImplToJson(
        _$ApiResponseGetAllStoryModelImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
