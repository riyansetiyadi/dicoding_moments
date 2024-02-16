// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiResponseLoginModel _$ApiResponseLoginModelFromJson(
    Map<String, dynamic> json) {
  return _ApiResponseLoginModel.fromJson(json);
}

/// @nodoc
mixin _$ApiResponseLoginModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  ProfileModel? get loginResult => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseLoginModelCopyWith<ApiResponseLoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseLoginModelCopyWith<$Res> {
  factory $ApiResponseLoginModelCopyWith(ApiResponseLoginModel value,
          $Res Function(ApiResponseLoginModel) then) =
      _$ApiResponseLoginModelCopyWithImpl<$Res, ApiResponseLoginModel>;
  @useResult
  $Res call({bool error, String message, ProfileModel? loginResult});

  $ProfileModelCopyWith<$Res>? get loginResult;
}

/// @nodoc
class _$ApiResponseLoginModelCopyWithImpl<$Res,
        $Val extends ApiResponseLoginModel>
    implements $ApiResponseLoginModelCopyWith<$Res> {
  _$ApiResponseLoginModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? loginResult = freezed,
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
      loginResult: freezed == loginResult
          ? _value.loginResult
          : loginResult // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res>? get loginResult {
    if (_value.loginResult == null) {
      return null;
    }

    return $ProfileModelCopyWith<$Res>(_value.loginResult!, (value) {
      return _then(_value.copyWith(loginResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseLoginModelImplCopyWith<$Res>
    implements $ApiResponseLoginModelCopyWith<$Res> {
  factory _$$ApiResponseLoginModelImplCopyWith(
          _$ApiResponseLoginModelImpl value,
          $Res Function(_$ApiResponseLoginModelImpl) then) =
      __$$ApiResponseLoginModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, ProfileModel? loginResult});

  @override
  $ProfileModelCopyWith<$Res>? get loginResult;
}

/// @nodoc
class __$$ApiResponseLoginModelImplCopyWithImpl<$Res>
    extends _$ApiResponseLoginModelCopyWithImpl<$Res,
        _$ApiResponseLoginModelImpl>
    implements _$$ApiResponseLoginModelImplCopyWith<$Res> {
  __$$ApiResponseLoginModelImplCopyWithImpl(_$ApiResponseLoginModelImpl _value,
      $Res Function(_$ApiResponseLoginModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? loginResult = freezed,
  }) {
    return _then(_$ApiResponseLoginModelImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      loginResult: freezed == loginResult
          ? _value.loginResult
          : loginResult // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseLoginModelImpl implements _ApiResponseLoginModel {
  const _$ApiResponseLoginModelImpl(
      {required this.error, required this.message, this.loginResult});

  factory _$ApiResponseLoginModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseLoginModelImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  @override
  final ProfileModel? loginResult;

  @override
  String toString() {
    return 'ApiResponseLoginModel(error: $error, message: $message, loginResult: $loginResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseLoginModelImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.loginResult, loginResult) ||
                other.loginResult == loginResult));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, loginResult);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseLoginModelImplCopyWith<_$ApiResponseLoginModelImpl>
      get copyWith => __$$ApiResponseLoginModelImplCopyWithImpl<
          _$ApiResponseLoginModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseLoginModelImplToJson(
      this,
    );
  }
}

abstract class _ApiResponseLoginModel implements ApiResponseLoginModel {
  const factory _ApiResponseLoginModel(
      {required final bool error,
      required final String message,
      final ProfileModel? loginResult}) = _$ApiResponseLoginModelImpl;

  factory _ApiResponseLoginModel.fromJson(Map<String, dynamic> json) =
      _$ApiResponseLoginModelImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  ProfileModel? get loginResult;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseLoginModelImplCopyWith<_$ApiResponseLoginModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
