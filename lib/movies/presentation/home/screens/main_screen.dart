import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common presentation/widgets/no_internet_connection_screen.dart';
import '../../../../core/utils/app setting/controller/app_setting_cubit.dart';
import '../../../../core/utils/app setting/styles/custom_background_color_gradient.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../widgets/now_playing_widget.dart';
import '../widgets/popular_widget.dart';
import '../widgets/top_rated_widget.dart';
import '../widgets/upcoming_movies_widget.dart';

class MainScreen extends StatefulWidget {
  static const String route = 'MainScreen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _movieCategories.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  final List<Widget> _movieCategories = [
    const PopularWidget(),
    const UpcomingMoviesWidget(),
    const TopRatedWidget(),
  ];

  final List<String> _movieCategoriesTitles = [
    AppStrings.popular,
    AppStrings.upcomingMovies,
    AppStrings.topRated
  ];

  @override
  Widget build(BuildContext context) {
    bool isInternetConnection =
        AppSettingCubit.object(context).isInternetConnection == false;
    final isDark = AppSettingCubit.object(context).theme == ThemeMode.dark;

    return isInternetConnection
        ? const NoInternetScreen()
        : Scaffold(
            body: CustomBackgroundColorGradient(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  flexibleSpace: const CustomBackgroundColorGradient(),
                  title: const Text(AppStrings.movies),
                  leading: IconButton(
                    onPressed: () =>
                        AppSettingCubit.object(context).changeTheme(),
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
                    IconButton(
                        onPressed: () async {},
                        icon: const Icon(Icons.search_sharp))
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const NowPlayingWidget(),
                      Align(alignment: Alignment.center, child: customTabBar()),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children:
                        _movieCategories.map((category) => category).toList(),
                  ),
                ),
              ],
            ),
          ));
  }

  Container customTabBar() {
    Size deviceSize = MediaQuery.sizeOf(context);

    final isDark = AppSettingCubit.object(context).theme == ThemeMode.dark;
    return Container(
      height: deviceSize.height * 0.055,
      decoration: BoxDecoration(
        color: isDark ? AppColors.customGreenColor : Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: TabBar(
        isScrollable: true,
        padding: EdgeInsets.zero,
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color:
              isDark ? AppColors.customGreyColor : AppColors.customOrangeColor,
        ),
        labelColor: Colors.white,
        labelStyle: GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: MediaQuery.sizeOf(context).width * 0.03,
          fontWeight: FontWeight.w800,
        )),
        unselectedLabelColor: Colors.black,
        tabs: _movieCategoriesTitles
            .map((categoryTitle) => Tab(text: categoryTitle))
            .toList(),
      ),
    );
  }
}
