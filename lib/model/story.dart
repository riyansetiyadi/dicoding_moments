import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.g.dart';

part 'story.freezed.dart';

@freezed

class StoryModel with _$StoryModel {
  const factory StoryModel({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    DateTime? createdAt,
    double? lat,
    double? lon,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}
