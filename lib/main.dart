import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/core/common%20presentation/splash/screens/splash_screen.dart';

import 'core/common presentation/screens/movie_details_screen.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/services_locator.dart';
import 'core/utils/app_strings.dart';
import 'core/utils/check internet/check_internet.dart';
import 'core/utils/check internet/no_internet_connection_screen.dart';
import 'core/utils/themes/controller/theme_cubit.dart';
import 'core/utils/themes/controller/theme_state.dart';
import 'core/utils/themes/styles/themes.dart';
import 'movies/presentation/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  ServicesLocator().init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// The following code is for checking the internet connection
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    mainScreen();
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  Widget home = const SplashScreen();

  void mainScreen() {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        home = const SplashScreen();
        break;
      case ConnectivityResult.wifi:
        home = const SplashScreen();
        break;

      case ConnectivityResult.none:
        home = const NotConnectivityScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    mainScreen();
    return BlocProvider(
      create: (context) => servicesLocator<ThemeCubit>()..getThemePref(),
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.movies,
            theme: AppThemes.light(context),
            darkTheme: AppThemes.dark(context),
            themeMode: ThemeCubit.object(context).theme,
            home: home,
            routes: {
              MovieDetailsScreen.route: (context) => const MovieDetailsScreen(),
              MainScreen.route: (context) => const MainScreen(),
            },
          );
        },
      ),
    );
  }
}
/*
 return BlocProvider(
      create: (context) => servicesLocator<ThemeCubit>()..getThemePref(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          mainScreen();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.movies,
            theme: AppThemes.light(context),
            darkTheme: AppThemes.dark(context),
            themeMode: ThemeCubit.object(context).theme,
            home: home,
            routes: {
              MovieDetailsScreen.route: (context) =>
              const MovieDetailsScreen(),
              MainScreen.route: (context) => const MainScreen(),
            },
          );
        },
      ),
    );
 */
