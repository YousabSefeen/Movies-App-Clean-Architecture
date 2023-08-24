import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/core/utils/check%20internet/no_internet_connection_screen.dart';
import 'package:flutter_movies_app/core/utils/themes/controller/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common presentation/splash/screens/splash_screen.dart';
import '../../app_colors.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  static ThemeCubit object(context) => BlocProvider.of(context);

  ThemeMode theme = ThemeMode.light;

  String textTheme = 'light';

  void changeTheme() async {
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;
      textTheme = 'dark';
      AppColors.colorGradient = AppColors.darkModeColorGradient;
    } else {
      theme = ThemeMode.light;
      textTheme = 'light';
      AppColors.colorGradient = AppColors.lightModeColorGradient;
    }
    emit(ChangeThemeState());
    final pref = await SharedPreferences.getInstance();
    pref.setString('textTheme', textTheme);
  }

  getThemePref() async {
    final pref = await SharedPreferences.getInstance();

    textTheme = pref.getString('textTheme') ?? 'light';

    if (textTheme == 'light') {
      theme = ThemeMode.light;

      AppColors.colorGradient = AppColors.lightModeColorGradient;
    } else if (textTheme == 'dark') {
      theme = ThemeMode.dark;
      AppColors.colorGradient = AppColors.darkModeColorGradient;
    }

    emit(GetThemeState());
  }

  StreamSubscription? _subscription;

  Widget mainScreen = const SplashScreen();

  void checkConnection() {
    emit(CheckConnectedState());
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {

      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        mainScreen = const SplashScreen();
        emit(ConnectedState(mainScreen));
      } else if (result == ConnectivityResult.none) {
        mainScreen = const NotConnectivityScreen();
        emit(NotConnectedState(mainScreen));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
