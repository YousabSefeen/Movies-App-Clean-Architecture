import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_colors.dart';
import '../controller/app_setting_cubit.dart';
import '../controller/app_setting_states.dart';

class CustomBackgroundColorGradient extends StatelessWidget {
  final Widget? child;

  const CustomBackgroundColorGradient({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingCubit, AppSettingStates>(
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
