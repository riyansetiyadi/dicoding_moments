import 'dart:async';

import 'package:dicoding_moments/api/api_service.dart';
import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/model/api_response_detail_story.dart';
import 'package:dicoding_moments/model/story.dart';
import 'package:dicoding_moments/utils/result_state.dart';
import 'package:flutter/material.dart';

class DetailStoryProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;
  final String idStory;

  DetailStoryProvider({
    required this.authRepository,
    required this.apiService,
    required this.idStory,
  }) {
    _fetchDetailStory(idStory);
  }

  String _message = '';
  String get message => _message;

  StoryModel? _storyResult;
  StoryModel? get story => _storyResult;

  ResultState _state = ResultState.init;
  ResultState get state => _state;

  Future<bool> refreshStory() async {
    return _fetchDetailStory(_storyResult?.id ?? '');
  }

  Future<bool> _fetchDetailStory(String idStory) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final profileState = await authRepository.getProfile();
      if (profileState != null) {
        String token = profileState.token;
        ApiResponseGetDetailStoryModel result =
            await apiService.getDetailStory(token, idStory);
        if (result.error) {
          _state = ResultState.error;
          _message = result.message;
          _storyResult = null;
          notifyListeners();
          return false;
        } else {
          _state = ResultState.hasData;
          _message = result.message;
          _storyResult = result.story;
          notifyListeners();
          return true;
        }
      } else {
        _state = ResultState.error;
        _message = "Login for story";
        _storyResult = null;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
      return false;
    }
  }
}
