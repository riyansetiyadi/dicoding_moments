import 'package:image_picker/image_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'post_story.freezed.dart';

@freezed

class PostStoryModel with _$PostStoryModel {
  const factory PostStoryModel({
    required String description,
    required String imagePath,
    @XFileAdapter() required XFile imageFile,
    double? lat,
    double? lon,
    List<int>? bytes,
  }) = _PostStoryModel;
}

class XFileAdapter implements JsonConverter<XFile, String> {
  const XFileAdapter();

  @override
  XFile fromJson(String json) {
    return XFile(json);
  }

  @override
  String toJson(XFile xFile) {
    return xFile.path;
  }
}
