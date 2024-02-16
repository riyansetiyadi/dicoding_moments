import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.g.dart';

part 'profile.freezed.dart';

@freezed

class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String name,
    required String userId,
    required String token,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}
