import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_colors.dart';
import '../controller/theme_cubit.dart';
import '../controller/theme_state.dart';

class CustomBackgroundColorGradient extends StatelessWidget {
  final Widget? child;

  const CustomBackgroundColorGradient({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.colorGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0, 1],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
