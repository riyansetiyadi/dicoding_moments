import 'dart:async';

import 'package:dicoding_moments/api/api_service.dart';
import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/model/api_response_detail_story.dart';
import 'package:dicoding_moments/model/loading_state.dart';
import 'package:dicoding_moments/model/story.dart';
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

  LoadingState _state = const LoadingState.initial();
  LoadingState get state => _state;

  Future<bool> refreshStory() async {
    return _fetchDetailStory(_storyResult?.id ?? '');
  }

  Future<bool> _fetchDetailStory(String idStory) async {
    try {
      _state = const LoadingState.loading();
      notifyListeners();
      final profileState = await authRepository.getProfile();
      if (profileState != null) {
        String token = profileState.token;
        ApiResponseGetDetailStoryModel result =
            await apiService.getDetailStory(token, idStory);
        if (result.error) {
          _message = result.message;
          _storyResult = null;
          _state = LoadingState.error(_message);
          notifyListeners();
          return false;
        } else {
          _message = result.message;
          _storyResult = result.story;
          _state = LoadingState.loaded(_storyResult);
          notifyListeners();
          return true;
        }
      } else {
        _message = "Login for story";
        _storyResult = null;
        _state = LoadingState.error(_message);
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = 'Error --> $e';
      _state = LoadingState.error(_message);
      notifyListeners();
      return false;
    }
  }
}
