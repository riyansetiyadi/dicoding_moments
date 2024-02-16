import 'dart:async';

import 'package:dicoding_moments/api/api_service.dart';
import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/model/api_response_get_all_story.dart';
import 'package:dicoding_moments/model/loading_state.dart';
import 'package:dicoding_moments/model/story.dart';
import 'package:flutter/material.dart';

class ListStoryProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;

  ListStoryProvider({required this.authRepository, required this.apiService});

  String _message = '';
  String get message => _message;

  List<StoryModel> _storyListResult = [];
  List<StoryModel> get storyList => _storyListResult;

  LoadingState _state = const LoadingState.initial();
  LoadingState get state => _state;

  LoadingState _infiniteScrollState = const LoadingState.initial();
  LoadingState get infiniteScrollState => _infiniteScrollState;

  int? pageItems = 1;
  int sizeItems = 10;

  Future<bool> refreshStories() async {
    try {
      final profileState = await authRepository.getProfile();
      if (profileState != null) {
        String token = profileState.token;
        ApiResponseGetAllStoryModel result = await apiService.getAllStory(
          token,
          page: 1,
          size: sizeItems,
        );
        if (result.error) {
          _message = result.message;
          notifyListeners();
          return false;
        } else {
          if (result.listStory.isEmpty) {
            _message = 'Empty Data';
            notifyListeners();
            return false;
          } else {
            _message = result.message;
            _storyListResult = result.listStory;
            _state = LoadingState.loaded(_storyListResult);
            pageItems = 2;
            notifyListeners();
            return true;
          }
        }
      } else {
        _message = "Login for story";
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = 'Error --> $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchStory() async {
    try {
      if (pageItems == 1) {
        _state = const LoadingState.loading();
      } else {
        _infiniteScrollState = const LoadingState.loading();
      }
      notifyListeners();

      final profileState = await authRepository.getProfile();

      if (profileState != null) {
        String token = profileState.token;
        ApiResponseGetAllStoryModel result = await apiService.getAllStory(
          token,
          page: pageItems,
          size: sizeItems,
        );
        if (result.error) {
          _message = result.message;
          if (pageItems == 1) {
            _state = LoadingState.error(_message);
          } else {
            _infiniteScrollState = LoadingState.error(_message);
          }
          notifyListeners();
          return false;
        } else {
          _message = result.message;
          _storyListResult.addAll(result.listStory);
          if (pageItems == 1) {
            _state = LoadingState.loaded(_storyListResult);
          } else {
            _infiniteScrollState = LoadingState.loaded(_storyListResult);
          }

          if (result.listStory.length < sizeItems) {
            pageItems = null;
          } else {
            pageItems = pageItems! + 1;
          }
          notifyListeners();
          return true;
        }
      } else {
        _message = "Login for story";
        if (pageItems == 1) {
          _state = LoadingState.error(_message);
        } else {
          _infiniteScrollState = LoadingState.error(_message);
        }
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = 'Error --> $e';
      if (pageItems == 1) {
        _state = LoadingState.error(_message);
      } else {
        _infiniteScrollState = LoadingState.error(_message);
      }
      notifyListeners();
      return false;
    }
  }
}
