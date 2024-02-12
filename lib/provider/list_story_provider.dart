import 'dart:async';

import 'package:dicoding_moments/api/api_service.dart';
import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/model/api_response_get_all_story.dart';
import 'package:dicoding_moments/model/story.dart';
import 'package:dicoding_moments/utils/result_state.dart';
import 'package:flutter/material.dart';

class ListStoryProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;

  ListStoryProvider({required this.authRepository, required this.apiService}) {
    _fetchAllStory();
  }

  String _message = '';
  String get message => _message;

  late List<StoryModel> _storyListResult;
  List<StoryModel> get storyList => _storyListResult;

  late ResultState _state;
  ResultState get state => _state;

  Future<bool> refreshStories() async {
    return _fetchAllStory();
  }

  Future<bool> _fetchAllStory() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final profileState = await authRepository.getProfile();
      if (profileState != null) {
        String token = profileState.token;
        ApiResponseGetAllStoryModel result =
            await apiService.getAllStory(token);
        if (result.error) {
          _state = ResultState.error;
          _message = result.message;
          _storyListResult = [];
          notifyListeners();
          return false;
        } else {
          if (result.listStory.isEmpty) {
            _state = ResultState.noData;
            _message = 'Empty Data';
            _storyListResult = [];
            notifyListeners();
            return false;
          } else {
            _state = ResultState.hasData;
            _message = result.message;
            _storyListResult = result.listStory;
            notifyListeners();
            return true;
          }
        }
      } else {
        _state = ResultState.error;
        _message = "Login for story";
        _storyListResult = [];
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
