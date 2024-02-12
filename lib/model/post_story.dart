import 'package:image_picker/image_picker.dart';

class PostStoryModel {
  final String description;
  final String imagePath;
  final XFile imageFile;
  final double? lat;
  final double? lon;

  PostStoryModel({
    required this.description,
    required this.imagePath,
    required this.imageFile,
    this.lat,
    this.lon,
  });
}
