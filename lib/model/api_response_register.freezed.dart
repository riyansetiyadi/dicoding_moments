// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_register.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiResponseRegisterModel _$ApiResponseRegisterModelFromJson(
    Map<String, dynamic> json) {
  return _ApiResponseRegisterModel.fromJson(json);
}

/// @nodoc
mixin _$ApiResponseRegisterModel {
  bool get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseRegisterModelCopyWith<ApiResponseRegisterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseRegisterModelCopyWith<$Res> {
  factory $ApiResponseRegisterModelCopyWith(ApiResponseRegisterModel value,
          $Res Function(ApiResponseRegisterModel) then) =
      _$ApiResponseRegisterModelCopyWithImpl<$Res, ApiResponseRegisterModel>;
  @useResult
  $Res call({bool error, String? message});
}

/// @nodoc
class _$ApiResponseRegisterModelCopyWithImpl<$Res,
        $Val extends ApiResponseRegisterModel>
    implements $ApiResponseRegisterModelCopyWith<$Res> {
  _$ApiResponseRegisterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiResponseRegisterModelImplCopyWith<$Res>
    implements $ApiResponseRegisterModelCopyWith<$Res> {
  factory _$$ApiResponseRegisterModelImplCopyWith(
          _$ApiResponseRegisterModelImpl value,
          $Res Function(_$ApiResponseRegisterModelImpl) then) =
      __$$ApiResponseRegisterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String? message});
}

/// @nodoc
class __$$ApiResponseRegisterModelImplCopyWithImpl<$Res>
    extends _$ApiResponseRegisterModelCopyWithImpl<$Res,
        _$ApiResponseRegisterModelImpl>
    implements _$$ApiResponseRegisterModelImplCopyWith<$Res> {
  __$$ApiResponseRegisterModelImplCopyWithImpl(
      _$ApiResponseRegisterModelImpl _value,
      $Res Function(_$ApiResponseRegisterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = freezed,
  }) {
    return _then(_$ApiResponseRegisterModelImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseRegisterModelImpl implements _ApiResponseRegisterModel {
  const _$ApiResponseRegisterModelImpl({required this.error, this.message});

  factory _$ApiResponseRegisterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseRegisterModelImplFromJson(json);

  @override
  final bool error;
  @override
  final String? message;

  @override
  String toString() {
    return 'ApiResponseRegisterModel(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseRegisterModelImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseRegisterModelImplCopyWith<_$ApiResponseRegisterModelImpl>
      get copyWith => __$$ApiResponseRegisterModelImplCopyWithImpl<
          _$ApiResponseRegisterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseRegisterModelImplToJson(
      this,
    );
  }
}

abstract class _ApiResponseRegisterModel implements ApiResponseRegisterModel {
  const factory _ApiResponseRegisterModel(
      {required final bool error,
      final String? message}) = _$ApiResponseRegisterModelImpl;

  factory _ApiResponseRegisterModel.fromJson(Map<String, dynamic> json) =
      _$ApiResponseRegisterModelImpl.fromJson;

  @override
  bool get error;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseRegisterModelImplCopyWith<_$ApiResponseRegisterModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
