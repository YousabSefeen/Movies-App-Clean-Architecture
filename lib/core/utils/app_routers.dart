import 'package:flutter/cupertino.dart';

import '../../movies/presentation/home/screens/main_screen.dart';
import '../../movies/presentation/movie details/screens/movie_details_screen.dart';
import '../common presentation/widgets/no_internet_connection_screen.dart';

class AppRouters {
  static Map<String, Widget Function(BuildContext)> routers = {
    MovieDetailsScreen.route: (context) => const MovieDetailsScreen(),
    MainScreen.route: (context) => const MainScreen(),
    NoInternetScreen.route: (context) => const NoInternetScreen(),
  };

  static go({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }

  static pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static goAndReplacement({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) {
    Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
  }

  static void goAndRemoveUntil({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) =>
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        route,
        (Route<dynamic> route) => false,
      );
}
