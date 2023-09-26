import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/core/utils/app_colors.dart';
import 'package:flutter_movies_app/core/utils/app_strings.dart';

class SplashWidget extends StatelessWidget {
  final Animation<Offset> slidingImage;
  final Animation<Offset> slidingText;

  const SplashWidget({
    Key? key,
    required this.slidingImage,
    required this.slidingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: slidingText,
          builder: (context, _) => SlideTransition(
            position: slidingText,
            child: Container(
              transform: Matrix4.rotationZ(-10 * (pi / 180)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 35),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.lightModeColorGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 1],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.white,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
              child: Text(
                AppStrings.movies,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedBuilder(
          animation: slidingImage,
          builder: (context, _) => SlideTransition(
            position: slidingImage,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
