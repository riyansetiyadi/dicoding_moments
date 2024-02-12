import 'package:dicoding_moments/api/api_service.dart';
import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/model/api_response_add_story.dart';
import 'package:dicoding_moments/model/post_story.dart';
import 'package:dicoding_moments/utils/result_state.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:image/image.dart' as img;

class PostStoryProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;

  PostStoryProvider({required this.authRepository, required this.apiService});

  String _message = "";
  String get message => _message;

  ResultState _state = ResultState.init;
  ResultState get state => _state;

  ApiResponseAddStoryModel? _result;
  ApiResponseAddStoryModel? get result => _result;

  String? imagePath;

  XFile? imageFile;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future<bool> postStory(
    PostStoryModel postStory,
  ) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final profileState = await authRepository.getProfile();

      final fileName = postStory.imageFile.name;
      final bytes = await postStory.imageFile.readAsBytes();
      final newBytes = await compressImage(bytes);
      if (profileState != null) {
        String token = profileState.token;
        _result = await apiService.addStoryApi(
          token,
          newBytes,
          fileName,
          postStory.description,
        );
        if (_result?.error ?? false) {
          _state = ResultState.error;
          _message = _result?.message ?? "error";
          notifyListeners();
          return false;
        } else {
          _message = _result?.message ?? "success";
          _state = ResultState.hasData;
          imageFile = null;
          imagePath = null;
          notifyListeners();
          return true;
        }
      } else {
        _state = ResultState.error;
        _message = "Login for post story";
        notifyListeners();
        return false;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<List<int>> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}
