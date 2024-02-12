import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/model/api_response_login.dart';
import 'package:dicoding_moments/model/api_response_register.dart';
import 'package:dicoding_moments/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_moments/api/api_service.dart';

import '../model/user.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;

  AuthProvider(this.authRepository, this.apiService) {
    _init();
  }

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;
  String? message;
  ProfileModel? profile;

  _init() async {
    profile = await authRepository.getProfile();
  }

  Future<bool> login(User user) async {
    isLoadingLogin = true;
    notifyListeners();

    profile = await authRepository.getProfile();
    if (profile == null) {
      ApiResponseLoginModel result = await apiService.loginApi(user);
      message = result.message;
      if (!result.error && result.loginResult != null) {
        await authRepository.saveProfile(result.loginResult!);
        profile = result.loginResult;
      }
    }
    isLoggedIn = await authRepository.isLoggedIn();
    isLoadingLogin = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    await authRepository.deleteProfile();
    isLoggedIn = await authRepository.isLoggedIn();

    isLoadingLogout = false;
    notifyListeners();

    return !isLoggedIn;
  }

  Future<bool> register(User user) async {
    isLoadingRegister = true;
    notifyListeners();

    ApiResponseRegisterModel result = await apiService.registerApi(user);

    isLoadingRegister = false;
    message = result.message;
    notifyListeners();

    return !result.error;
  }
}
