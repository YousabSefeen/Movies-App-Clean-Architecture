import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_colors.dart';
import 'app_setting_states.dart';

class AppSettingCubit extends Cubit<AppSettingStates> {
  AppSettingCubit() : super(AppSettingInitialState());

  static AppSettingCubit object(context) => BlocProvider.of(context);

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

  bool isInternetConnection = false;
  StreamSubscription? _streamSubscription;

  void checkInternetConnection() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        isInternetConnection = true;
        emit(InternetConnectionState());
      } else {
        emit(NoInternetConnectionState());
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription!.cancel();
    return super.close();
  }
}
