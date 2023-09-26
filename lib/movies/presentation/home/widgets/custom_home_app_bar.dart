import 'package:flutter/material.dart';

import '../../../../core/utils/app setting/controller/app_setting_cubit.dart';
import '../../../../core/utils/app setting/styles/custom_background_color_gradient.dart';
import '../../../../core/utils/app_strings.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = AppSettingCubit.object(context).theme == ThemeMode.dark;
    return SliverAppBar(
      pinned: true,
      flexibleSpace: const CustomBackgroundColorGradient(),
      title: const Text(AppStrings.movies),
      leading: IconButton(
        onPressed: () => AppSettingCubit.object(context).changeTheme(),
        icon: CircleAvatar(
          backgroundColor: Theme.of(context).splashColor,
          radius: 20,
          child: Icon(
            isDark ? Icons.sunny : Icons.dark_mode_rounded,
            color: isDark ? Colors.amber : Colors.black,
          ),
        ),
      ),
      actions: [
        IconButton(onPressed: () async {}, icon: const Icon(Icons.search_sharp))
      ],
    );
  }
}
