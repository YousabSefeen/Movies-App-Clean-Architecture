import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/movies/domain/entities/movie_details.dart';

import '../../../../core/common presentation/widgets/custom_error_widget.dart';
import '../../../../core/common presentation/widgets/custom_release_date.dart';
import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/genres.dart';
import '../controller/cubit/movie_details_cubit.dart';
import '../controller/states/movie_details_state.dart';
import 'custom_app_bar.dart';
import 'custom_rich_text.dart';
import 'movie_details_background.dart';
import 'movie_image_widget.dart';
import 'movies_recommendations_widget.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //  final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      buildWhen: (previous, current) =>
          previous.movieDetailsState != current.movieDetailsState,
      builder: (context, state) {
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            final movie = state.movieDetails;
            return Stack(
              children: [
                MovieDetailsBackground(
                  id: movie!.id,
                  imageUrl: ApiConstants.imageUrl(movie.posterPath),
                ),
                Column(
                  children: [
                    const CustomAppBar(),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 90, 16, 5),
                            child: Card(
                              child: Column(
                                children: [
                                  _movieNameAndRating(movie, textTheme),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child:
                                          _movieInfo(textTheme, movie, state),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 40,
                            child: MovieImageWidget(movie: movie),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );

          case RequestState.error:
            return Center(
              child: CustomErrorWidget(
                errorMessage: state.movieDetailsMessage,
                errorMovieCategoryName: AppStrings.movieDetails,
              ),
            );
        }
      },
    );
  }

  Container _movieNameAndRating(MovieDetails movie, TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.only(left: 115.0),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              movie.title.toString().split(':')[0],
              style: textTheme.headlineLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.star),
            label: Text(
              movie.voteAverage.toStringAsFixed(1),
              style: textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Padding _movieInfo(
    TextTheme textTheme,
    MovieDetails movie,
    MovieDetailsState state,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppStrings.releaseDate,
                style: textTheme.headlineMedium,
              ),
              CustomReleaseDate(
                releaseDate: movie.releaseDate,
              ),
            ],
          ),
          CustomRichText(
            text1: AppStrings.duration,
            text2: _showDuration(state.movieDetails!.runtime),
          ),
          const SizedBox(height: 10),
          CustomRichText(
            text1: AppStrings.genres,
            text2: _showGenres(movie.genres),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Text(
              AppStrings.overview,
              style: textTheme.headlineMedium,
            ),
          ),
          Text(
            movie.overview,
            style: textTheme.headlineSmall!.copyWith(height: 1.2),
          ),
          const MoviesRecommendationsWidget(),
        ],
      ),
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
