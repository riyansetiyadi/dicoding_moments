import 'package:dicoding_moments/api/api_service.dart';
import 'package:dicoding_moments/db/auth_repository.dart';
import 'package:dicoding_moments/provider/auth_provider.dart';
import 'package:dicoding_moments/provider/detail_story_provider.dart';
import 'package:dicoding_moments/provider/list_story_provider.dart';
import 'package:dicoding_moments/provider/localization_provider.dart';
import 'package:dicoding_moments/provider/post_story_provider.dart';
import 'package:dicoding_moments/routes/page_manager.dart';
import 'package:dicoding_moments/routes/router_delegate.dart';
import 'package:dicoding_moments/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const StoryApp());
}

class StoryApp extends StatefulWidget {
  const StoryApp({Key? key}) : super(key: key);

  @override
  State<StoryApp> createState() => _StoryAppState();
}

class _StoryAppState extends State<StoryApp> {
  late MyRouterDelegate myRouterDelegate;

  late AuthProvider authProvider;
  late ListStoryProvider listStoryProvider;
  late DetailStoryProvider detailStoryProvider;
  late PostStoryProvider postStoryProvider;
  String? idStory;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final apiService = ApiService();

    authProvider = AuthProvider(
      authRepository,
      apiService,
    );

    postStoryProvider = PostStoryProvider(
      authRepository: authRepository,
      apiService: apiService,
    );

    myRouterDelegate = MyRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PageManager(),
        ),
        ChangeNotifierProvider(
          create: (context) => authProvider,
        ),
        ChangeNotifierProvider<ListStoryProvider>(
          create: (context) => ListStoryProvider(
            authRepository: AuthRepository(),
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<PostStoryProvider>(
          create: (context) => postStoryProvider,
        ),
      ],
      child: ChangeNotifierProvider<LocalizationProvider>(
        create: (context) => LocalizationProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocalizationProvider>(context);
          return MaterialApp(
            title: 'Dicoding Moments',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('id', ''),
              Locale('en', ''),
            ],
            locale: provider.locale,
            home: Router(
              routerDelegate: myRouterDelegate,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
