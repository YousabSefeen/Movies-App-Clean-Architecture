import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/core/common%20presentation/splash/screens/splash_screen.dart';
import 'package:flutter_movies_app/core/utils/app_routers.dart';

import 'core/services/bloc_observer.dart';
import 'core/services/services_locator.dart';
import 'core/utils/app setting/controller/app_setting_cubit.dart';
import 'core/utils/app setting/controller/app_setting_states.dart';
import 'core/utils/app setting/styles/themes.dart';
import 'core/utils/app_strings.dart';
import 'movies/presentation/home/controller/cubit/movies_cubit.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => servicesLocator<AppSettingCubit>()
        ..getThemePref()
        ..checkInternetConnection(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => servicesLocator<AppSettingCubit>()
              ..getThemePref()
              ..checkInternetConnection(),
          ),
          BlocProvider(
            create: (context) => servicesLocator<MoviesCubit>()
              ..getNowPlayingMovies()
              ..getPopularMovies()
              ..getTopRatedMovies()
              ..getUpcomingMovies(),
          ),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.movies,
              theme: AppThemes.light(context),
              darkTheme: AppThemes.dark(context),
              themeMode: AppSettingCubit.object(context).theme,
              home: const SplashScreen(),
              routes: AppRouters.routers,
            );
          },
        ),
      ),
    );
  }
}
