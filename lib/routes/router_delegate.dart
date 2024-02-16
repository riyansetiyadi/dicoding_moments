import 'package:dicoding_moments/screen/language_settings_screen.dart';
import 'package:dicoding_moments/screen/map_screen.dart';
import 'package:dicoding_moments/screen/post_screen.dart';
import 'package:dicoding_moments/screen/profile_screen.dart';
import 'package:dicoding_moments/screen/story_detail_screen.dart';
import 'package:dicoding_moments/screen/story_list_screen.dart';
import 'package:dicoding_moments/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final ScrollController scrollControllerStoryList = ScrollController();

  @override
  void dispose() {
    scrollControllerStoryList.dispose();
    super.dispose();
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
  bool isMapScreen = false;
  LatLng? currentPickLocation;

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

          if (currentBottomNavigationIndex == 0) {
            if (selectedStory != null) {
              if (isMapScreen) {
                isMapScreen = false;
                notifyListeners();
                return true;
              }

              selectedStory = null;
              notifyListeners();
              return true;
            }
          } else if (currentBottomNavigationIndex == 1) {
            if (isMapScreen) {
              isMapScreen = false;
              currentPickLocation = null;
              notifyListeners();
              return true;
            }
          } else if (currentBottomNavigationIndex == 2) {
            if (isLanguageScreen) {
              isLanguageScreen = false;
              notifyListeners();
              return true;
            }
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
                  if (currentBottomNavigationIndex == index) {
                    if (scrollControllerStoryList.hasClients) {
                      final position =
                          scrollControllerStoryList.position.minScrollExtent -
                              100;
                      scrollControllerStoryList.animateTo(
                        position,
                        curve: Curves.easeInCubic,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                  }
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
            scrollController: scrollControllerStoryList,
          ),
        ),
        if (selectedStory != null)
          MaterialPage(
            key: ValueKey("DetailStoryPage $selectedStory"),
            child: StoryDetailsScreen(
              storyId: selectedStory!,
              toMapScreen: (newCurrentPickLocation) {
                isMapScreen = true;
                currentPickLocation = newCurrentPickLocation;
                notifyListeners();
              },
            ),
          ),
        if (currentBottomNavigationIndex == 1)
          MaterialPage(
            key: const ValueKey("PostPage"),
            child: PostScreen(
              toMapScreen: (newCurrentPickLocation) {
                isMapScreen = true;
                currentPickLocation = newCurrentPickLocation;
                notifyListeners();
              },
              onPostSuccess: () {
                currentBottomNavigationIndex = 0;
                final position =
                    scrollControllerStoryList.position.minScrollExtent - 100;
                scrollControllerStoryList.animateTo(
                  position,
                  curve: Curves.easeInCubic,
                  duration: const Duration(milliseconds: 300),
                );
                notifyListeners();
              },
            ),
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
        if (isMapScreen && currentBottomNavigationIndex == 1)
          MaterialPage(
            key: const ValueKey("MapPage"),
            child: MapScreen(
              currentLocation: currentPickLocation,
            ),
          )
        else if (isMapScreen && selectedStory != null)
          MaterialPage(
            key: const ValueKey("MapPage"),
            child: MapScreen(
              currentLocation: currentPickLocation,
              isFromDetailScreen: true,
            ),
          )
        else if (isLanguageScreen)
          const MaterialPage(
            key: ValueKey("LanguageSettingsPage"),
            child: LanguageSettingsScreen(),
          )
      ];
}
