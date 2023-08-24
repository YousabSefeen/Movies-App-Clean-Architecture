import 'package:flutter/cupertino.dart';

abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ChangeThemeState extends ThemeState {}

class GetThemeState extends ThemeState {}

class CheckConnectedState extends ThemeState {}
class ConnectedState extends ThemeState {
 final Widget  mainScreen ;
   ConnectedState(this.mainScreen);
}

class NotConnectedState extends ThemeState {
  final Widget  mainScreen ;
  NotConnectedState(this.mainScreen);
}
