import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/core/utils/app_routers.dart';

import '../../../movies/presentation/home/screens/main_screen.dart';
import '../../utils/app setting/controller/app_setting_cubit.dart';
import '../../utils/app setting/controller/app_setting_states.dart';

class NoInternetScreen extends StatelessWidget {
  static const route = 'NoInternetScreen';

  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppSettingCubit, AppSettingStates>(
      listener: (context, state) {
        if (state is InternetConnectionState) {
          AppRouters.goAndRemoveUntil(
            context: context,
            route: MainScreen.route,
          );
        }
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.15),
                Container(
                  height: constraints.maxHeight * 0.50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/no_internet.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.20,
                  child: const Text(
                    'Can\'t connect..check internet.',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
