// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_get_all_story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiResponseGetAllStoryModel _$ApiResponseGetAllStoryModelFromJson(
    Map<String, dynamic> json) {
  return _ApiResponseGetAllStoryModel.fromJson(json);
}

/// @nodoc
mixin _$ApiResponseGetAllStoryModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<StoryModel> get listStory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseGetAllStoryModelCopyWith<ApiResponseGetAllStoryModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseGetAllStoryModelCopyWith<$Res> {
  factory $ApiResponseGetAllStoryModelCopyWith(
          ApiResponseGetAllStoryModel value,
          $Res Function(ApiResponseGetAllStoryModel) then) =
      _$ApiResponseGetAllStoryModelCopyWithImpl<$Res,
          ApiResponseGetAllStoryModel>;
  @useResult
  $Res call({bool error, String message, List<StoryModel> listStory});
}

/// @nodoc
class _$ApiResponseGetAllStoryModelCopyWithImpl<$Res,
        $Val extends ApiResponseGetAllStoryModel>
    implements $ApiResponseGetAllStoryModelCopyWith<$Res> {
  _$ApiResponseGetAllStoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
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
      listStory: null == listStory
          ? _value.listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiResponseGetAllStoryModelImplCopyWith<$Res>
    implements $ApiResponseGetAllStoryModelCopyWith<$Res> {
  factory _$$ApiResponseGetAllStoryModelImplCopyWith(
          _$ApiResponseGetAllStoryModelImpl value,
          $Res Function(_$ApiResponseGetAllStoryModelImpl) then) =
      __$$ApiResponseGetAllStoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, List<StoryModel> listStory});
}

/// @nodoc
class __$$ApiResponseGetAllStoryModelImplCopyWithImpl<$Res>
    extends _$ApiResponseGetAllStoryModelCopyWithImpl<$Res,
        _$ApiResponseGetAllStoryModelImpl>
    implements _$$ApiResponseGetAllStoryModelImplCopyWith<$Res> {
  __$$ApiResponseGetAllStoryModelImplCopyWithImpl(
      _$ApiResponseGetAllStoryModelImpl _value,
      $Res Function(_$ApiResponseGetAllStoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(_$ApiResponseGetAllStoryModelImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: null == listStory
          ? _value._listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseGetAllStoryModelImpl
    implements _ApiResponseGetAllStoryModel {
  const _$ApiResponseGetAllStoryModelImpl(
      {required this.error,
      required this.message,
      required final List<StoryModel> listStory})
      : _listStory = listStory;

  factory _$ApiResponseGetAllStoryModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ApiResponseGetAllStoryModelImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  final List<StoryModel> _listStory;
  @override
  List<StoryModel> get listStory {
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listStory);
  }

  @override
  String toString() {
    return 'ApiResponseGetAllStoryModel(error: $error, message: $message, listStory: $listStory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseGetAllStoryModelImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._listStory, _listStory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message,
      const DeepCollectionEquality().hash(_listStory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseGetAllStoryModelImplCopyWith<_$ApiResponseGetAllStoryModelImpl>
      get copyWith => __$$ApiResponseGetAllStoryModelImplCopyWithImpl<
          _$ApiResponseGetAllStoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseGetAllStoryModelImplToJson(
      this,
    );
  }
}

abstract class _ApiResponseGetAllStoryModel
    implements ApiResponseGetAllStoryModel {
  const factory _ApiResponseGetAllStoryModel(
          {required final bool error,
          required final String message,
          required final List<StoryModel> listStory}) =
      _$ApiResponseGetAllStoryModelImpl;

  factory _ApiResponseGetAllStoryModel.fromJson(Map<String, dynamic> json) =
      _$ApiResponseGetAllStoryModelImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  List<StoryModel> get listStory;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseGetAllStoryModelImplCopyWith<_$ApiResponseGetAllStoryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
