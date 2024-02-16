// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_detail_story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiResponseGetDetailStoryModel _$ApiResponseGetDetailStoryModelFromJson(
    Map<String, dynamic> json) {
  return _ApiResponseGetDetailStoryModel.fromJson(json);
}

/// @nodoc
mixin _$ApiResponseGetDetailStoryModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  StoryModel get story => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseGetDetailStoryModelCopyWith<ApiResponseGetDetailStoryModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseGetDetailStoryModelCopyWith<$Res> {
  factory $ApiResponseGetDetailStoryModelCopyWith(
          ApiResponseGetDetailStoryModel value,
          $Res Function(ApiResponseGetDetailStoryModel) then) =
      _$ApiResponseGetDetailStoryModelCopyWithImpl<$Res,
          ApiResponseGetDetailStoryModel>;
  @useResult
  $Res call({bool error, String message, StoryModel story});

  $StoryModelCopyWith<$Res> get story;
}

/// @nodoc
class _$ApiResponseGetDetailStoryModelCopyWithImpl<$Res,
        $Val extends ApiResponseGetDetailStoryModel>
    implements $ApiResponseGetDetailStoryModelCopyWith<$Res> {
  _$ApiResponseGetDetailStoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? story = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      story: null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as StoryModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoryModelCopyWith<$Res> get story {
    return $StoryModelCopyWith<$Res>(_value.story, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseGetDetailStoryModelImplCopyWith<$Res>
    implements $ApiResponseGetDetailStoryModelCopyWith<$Res> {
  factory _$$ApiResponseGetDetailStoryModelImplCopyWith(
          _$ApiResponseGetDetailStoryModelImpl value,
          $Res Function(_$ApiResponseGetDetailStoryModelImpl) then) =
      __$$ApiResponseGetDetailStoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, StoryModel story});

  @override
  $StoryModelCopyWith<$Res> get story;
}

/// @nodoc
class __$$ApiResponseGetDetailStoryModelImplCopyWithImpl<$Res>
    extends _$ApiResponseGetDetailStoryModelCopyWithImpl<$Res,
        _$ApiResponseGetDetailStoryModelImpl>
    implements _$$ApiResponseGetDetailStoryModelImplCopyWith<$Res> {
  __$$ApiResponseGetDetailStoryModelImplCopyWithImpl(
      _$ApiResponseGetDetailStoryModelImpl _value,
      $Res Function(_$ApiResponseGetDetailStoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? story = null,
  }) {
    return _then(_$ApiResponseGetDetailStoryModelImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      story: null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as StoryModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseGetDetailStoryModelImpl
    implements _ApiResponseGetDetailStoryModel {
  const _$ApiResponseGetDetailStoryModelImpl(
      {required this.error, required this.message, required this.story});

  factory _$ApiResponseGetDetailStoryModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ApiResponseGetDetailStoryModelImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  @override
  final StoryModel story;

  @override
  String toString() {
    return 'ApiResponseGetDetailStoryModel(error: $error, message: $message, story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseGetDetailStoryModelImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, story);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseGetDetailStoryModelImplCopyWith<
          _$ApiResponseGetDetailStoryModelImpl>
      get copyWith => __$$ApiResponseGetDetailStoryModelImplCopyWithImpl<
          _$ApiResponseGetDetailStoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseGetDetailStoryModelImplToJson(
      this,
    );
  }
}

abstract class _ApiResponseGetDetailStoryModel
    implements ApiResponseGetDetailStoryModel {
  const factory _ApiResponseGetDetailStoryModel(
      {required final bool error,
      required final String message,
      required final StoryModel story}) = _$ApiResponseGetDetailStoryModelImpl;

  factory _ApiResponseGetDetailStoryModel.fromJson(Map<String, dynamic> json) =
      _$ApiResponseGetDetailStoryModelImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  StoryModel get story;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseGetDetailStoryModelImplCopyWith<
          _$ApiResponseGetDetailStoryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
