import 'package:flutter/material.dart';
import 'package:flutter_movies_app/core/utils/app_routers.dart';

import '../../../../movies/presentation/home/screens/main_screen.dart';
import '../widgets/splash_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _slidingImage;
  late Animation<Offset> _slidingText;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _navigatorToHome();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SplashWidget(
          slidingImage: _slidingImage,
          slidingText: _slidingText,
        ),
      ),
    );
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _slidingText = Tween<Offset>(
      begin: const Offset(0, 7),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInQuint));

    _slidingImage = Tween<Offset>(
      begin: const Offset(0, -4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInQuint));
    _animationController.forward();
  }

  void _navigatorToHome() {
    Future.delayed(
      const Duration(seconds: 2),
      () => AppRouters.goAndReplacement(
        context: context,
        route: MainScreen.route,
      ),
    );
  }
}
