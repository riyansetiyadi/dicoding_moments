import 'package:dicoding_moments/screen/language_settings_screen.dart';
import 'package:dicoding_moments/screen/post_screen.dart';
import 'package:dicoding_moments/screen/profile_screen.dart';
import 'package:dicoding_moments/screen/story_detail_screen.dart';
import 'package:dicoding_moments/screen/story_list_screen.dart';
import 'package:dicoding_moments/screen/register_screen.dart';
import 'package:flutter/material.dart';

import '../db/auth_repository.dart';
import '../screen/login_screen.dart';
import '../screen/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  MyRouterDelegate(
    this.authRepository,
  ) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    var result = await Future.wait([
      Future.delayed(const Duration(seconds: 5)),
      authRepository.isLoggedIn(),
    ]);
    isLoggedIn = result[1];
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  String? selectedStory;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  int currentBottomNavigationIndex = 0;
  bool isLanguageScreen = false;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        pages: historyStack,
        onPopPage: (route, result) {
          final didPop = route.didPop(result);

          if (!didPop) {
            return false;
          }

          if (currentBottomNavigationIndex == 2 && isLanguageScreen) {
            isLanguageScreen = false;
            return true;
          }

          isRegister = false;
          selectedStory = null;
          currentBottomNavigationIndex = 0;
          notifyListeners();

          return true;
        },
      ),
      bottomNavigationBar: (isLoggedIn == true &&
              currentBottomNavigationIndex != 1 &&
              selectedStory == null)
          ? BottomNavigationBar(
              selectedFontSize: 0,
              currentIndex: currentBottomNavigationIndex,
              onTap: (index) {
                if (index == 0) {
                  currentBottomNavigationIndex = 0;
                } else if (index == 1) {
                  currentBottomNavigationIndex = 1;
                } else if (index == 2) {
                  currentBottomNavigationIndex = 2;
                }
                notifyListeners();
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
            )
          : null,
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashScreen"),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterScreen(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("StoryListPage"),
          child: StoryListScreen(
            onTapped: (String storyId) {
              selectedStory = storyId;
              notifyListeners();
            },
          ),
        ),
        if (selectedStory != null)
          MaterialPage(
            key: ValueKey("DetailStoryPage $selectedStory"),
            child: StoryDetailsScreen(
              storyId: selectedStory!,
            ),
          ),
        if (currentBottomNavigationIndex == 1)
          const MaterialPage(
            key: ValueKey("PostPage"),
            child: PostScreen(),
          )
        else if (currentBottomNavigationIndex == 2)
          MaterialPage(
            key: const ValueKey("ProfilePage"),
            child: ProfileScreen(
              onLogout: () {
                isLoggedIn = false;
                currentBottomNavigationIndex = 0;
                notifyListeners();
              },
              onLanguageSettingsScreen: () {
                isLanguageScreen = true;
                notifyListeners();
              },
            ),
          ),
        if (currentBottomNavigationIndex == 2 && isLanguageScreen)
          const MaterialPage(
            key: ValueKey("LanguageSettingsPage"),
            child: LanguageSettingsScreen(),
          )
      ];
}
