import 'dart:convert';
import 'dart:typed_data';
import 'package:dicoding_moments/model/api_response_add_story.dart';
import 'package:dicoding_moments/model/api_response_detail_story.dart';
import 'package:dicoding_moments/model/api_response_get_all_story.dart';
import 'package:dicoding_moments/model/api_response_login.dart';
import 'package:dicoding_moments/model/api_response_register.dart';
import 'package:dicoding_moments/model/post_story.dart';
import 'package:dicoding_moments/model/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<ApiResponseRegisterModel> registerApi(User user) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 400) {
      final apiResponse =
          ApiResponseRegisterModel.fromJson(json.decode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<ApiResponseLoginModel> loginApi(User user) async {
    Map userJson = user.toJson();
    userJson.remove("name");
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userJson),
    );
    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      final apiResponse =
          ApiResponseLoginModel.fromJson(json.decode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<ApiResponseAddStoryModel> addStoryApi(
    String token,
    PostStoryModel story,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$_baseUrl/stories"),
    );

    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      story.bytes ?? [],
      filename: story.imageFile.name,
    );
    final Map<String, String> fields = {
      "description": story.description,
      if (story.lat != null) "lat": story.lat.toString(),
      if (story.lon != null) "lon": story.lon.toString(),
    };
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $token',
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();

    final Uint8List responseList = await response.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (response.statusCode == 201) {
      final apiResponse =
          ApiResponseAddStoryModel.fromJson(json.decode(responseData));
      return apiResponse;
    } else {
      throw Exception('Failed to add story');
    }
  }

  Future<ApiResponseGetAllStoryModel> getAllStory(
    String token, {
    int? page,
    int? size,
    bool location = false,
  }) async {
    final queryParameters = {
      if (page != null) 'page': page.toString(),
      if (size != null) 'size': size.toString(),
      'location': location ? '1' : '0',
    };

    final uri = Uri.parse("$_baseUrl/stories")
        .replace(queryParameters: queryParameters);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final apiResponse =
          ApiResponseGetAllStoryModel.fromJson(json.decode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to get story');
    }
  }

  Future<ApiResponseGetDetailStoryModel> getDetailStory(
      String token, String id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories/$id"),
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final apiResponse =
          ApiResponseGetDetailStoryModel.fromJson(json.decode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to get story');
    }
  }
}
