import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common presentation/screens/movie_details_screen.dart';
import 'core/common presentation/splash/screens/splash_screen.dart';
import 'core/services/services_locator.dart';
import 'core/utils/app_strings.dart';
import 'core/utils/themes/controller/theme_cubit.dart';
import 'core/utils/themes/controller/theme_state.dart';
import 'core/utils/themes/styles/themes.dart';
import 'core/services/bloc_observer.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => servicesLocator<ThemeCubit>()..getThemePref(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.movies,
            theme: AppThemes.light(context),
            darkTheme: AppThemes.dark(context),
            themeMode: ThemeCubit.object(context).theme,
            home: const SplashScreen(),
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
