import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common presentation/widgets/custom_cached_network_image.dart';
import '../../../../core/common presentation/widgets/custom_error_widget.dart';
import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/movie.dart';
import '../../movie details/screens/movie_details_screen.dart';
import '../controller/cubit/movies_cubit.dart';
import '../controller/states/movies_state.dart';

class TopRatedWidget extends StatefulWidget {
  const TopRatedWidget({Key? key}) : super(key: key);

  @override
  State<TopRatedWidget> createState() => _TopRatedWidgetState();
}

class _TopRatedWidgetState extends State<TopRatedWidget> {
  PageController pageController = PageController();

  int counter = 0;

  void _incrementCounter() {
    counter++;
    setState(() {});
  }

  void _decrementCounter() {
    counter--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) =>
          previous.topRatedState != current.topRatedState,
      builder: (context, state) {
        switch (state.topRatedState) {
          case RequestState.loading:
            return Center(
              child: Text(
                AppStrings.loading,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.white),
              ),
            );
          case RequestState.loaded:
            Movie movie = state.topRatedMovies[counter];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                goingReverseMovies(theme),
                showMovieDetails(height, width, context, movie, theme),
                goingForwardMovies(state, theme),
              ],
            );

          case RequestState.error:
            return CustomErrorWidget(
              errorMessage: state.topRatedMessageError,
              errorMovieCategoryName: AppStrings.topRated,
            );
        }
      },
    );
  }

  Column goingReverseMovies(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(counter.toString()),
        IconButton(
          onPressed: counter == 0 ? null : () => _decrementCounter(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: counter == 0 ? Colors.grey.shade600 : theme.primaryColor,
          ),
        ),
      ],
    );
  }

  SizedBox showMovieDetails(double height, double width, BuildContext context,
      Movie movie, ThemeData theme) {
    return SizedBox(
      height: height * 0.57,
      width: width * 0.75,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          MovieDetailsScreen.route,
          arguments: movie.id,
        ),
        child: Column(
          children: [
            SizedBox(
              width: width * 0.7,
              child: Text(
                movie.title.toString().split(':')[0],
                style: theme.appBarTheme.titleTextStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton.icon(
              onPressed: null,
              icon: const Icon(Icons.star),
              label: Text(
                movie.voteAverage.toStringAsFixed(1),
                style: theme.textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomCachedNetworkImage(
                  imageUrl: ApiConstants.imageUrl(movie.backdropPath),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded goingForwardMovies(MoviesState state, ThemeData theme) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${state.topRatedMovies.length - 1 - counter}'),
          IconButton(
            onPressed: counter == state.topRatedMovies.length - 1
                ? null
                : () => _incrementCounter(),
            icon: Icon(
              Icons.arrow_forward_ios,
              color: counter == state.topRatedMovies.length - 1
                  ? Colors.grey.shade600
                  : theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
