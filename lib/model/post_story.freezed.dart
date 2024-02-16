// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostStoryModel {
  String get description => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  @XFileAdapter()
  XFile get imageFile => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  double? get lon => throw _privateConstructorUsedError;
  List<int>? get bytes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostStoryModelCopyWith<PostStoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostStoryModelCopyWith<$Res> {
  factory $PostStoryModelCopyWith(
          PostStoryModel value, $Res Function(PostStoryModel) then) =
      _$PostStoryModelCopyWithImpl<$Res, PostStoryModel>;
  @useResult
  $Res call(
      {String description,
      String imagePath,
      @XFileAdapter() XFile imageFile,
      double? lat,
      double? lon,
      List<int>? bytes});
}

/// @nodoc
class _$PostStoryModelCopyWithImpl<$Res, $Val extends PostStoryModel>
    implements $PostStoryModelCopyWith<$Res> {
  _$PostStoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? imagePath = null,
    Object? imageFile = null,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? bytes = freezed,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      imageFile: null == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as XFile,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double?,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostStoryModelImplCopyWith<$Res>
    implements $PostStoryModelCopyWith<$Res> {
  factory _$$PostStoryModelImplCopyWith(_$PostStoryModelImpl value,
          $Res Function(_$PostStoryModelImpl) then) =
      __$$PostStoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      String imagePath,
      @XFileAdapter() XFile imageFile,
      double? lat,
      double? lon,
      List<int>? bytes});
}

/// @nodoc
class __$$PostStoryModelImplCopyWithImpl<$Res>
    extends _$PostStoryModelCopyWithImpl<$Res, _$PostStoryModelImpl>
    implements _$$PostStoryModelImplCopyWith<$Res> {
  __$$PostStoryModelImplCopyWithImpl(
      _$PostStoryModelImpl _value, $Res Function(_$PostStoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? imagePath = null,
    Object? imageFile = null,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? bytes = freezed,
  }) {
    return _then(_$PostStoryModelImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      imageFile: null == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as XFile,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double?,
      bytes: freezed == bytes
          ? _value._bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc

class _$PostStoryModelImpl implements _PostStoryModel {
  const _$PostStoryModelImpl(
      {required this.description,
      required this.imagePath,
      @XFileAdapter() required this.imageFile,
      this.lat,
      this.lon,
      final List<int>? bytes})
      : _bytes = bytes;

  @override
  final String description;
  @override
  final String imagePath;
  @override
  @XFileAdapter()
  final XFile imageFile;
  @override
  final double? lat;
  @override
  final double? lon;
  final List<int>? _bytes;
  @override
  List<int>? get bytes {
    final value = _bytes;
    if (value == null) return null;
    if (_bytes is EqualUnmodifiableListView) return _bytes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PostStoryModel(description: $description, imagePath: $imagePath, imageFile: $imageFile, lat: $lat, lon: $lon, bytes: $bytes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostStoryModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            const DeepCollectionEquality().equals(other._bytes, _bytes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, description, imagePath,
      imageFile, lat, lon, const DeepCollectionEquality().hash(_bytes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostStoryModelImplCopyWith<_$PostStoryModelImpl> get copyWith =>
      __$$PostStoryModelImplCopyWithImpl<_$PostStoryModelImpl>(
          this, _$identity);
}

abstract class _PostStoryModel implements PostStoryModel {
  const factory _PostStoryModel(
      {required final String description,
      required final String imagePath,
      @XFileAdapter() required final XFile imageFile,
      final double? lat,
      final double? lon,
      final List<int>? bytes}) = _$PostStoryModelImpl;

  @override
  String get description;
  @override
  String get imagePath;
  @override
  @XFileAdapter()
  XFile get imageFile;
  @override
  double? get lat;
  @override
  double? get lon;
  @override
  List<int>? get bytes;
  @override
  @JsonKey(ignore: true)
  _$$PostStoryModelImplCopyWith<_$PostStoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
