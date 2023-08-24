import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../movies/domain/entities/genres.dart';
import '../../../movies/domain/entities/recommendation.dart';
import '../../../movies/presentation/controller/cubit/movie_details_cubit.dart';
import '../../../movies/presentation/controller/states/movie_details_state.dart';
import '../../utils/api_constants.dart';
import '../../utils/app_strings.dart';
import '../../utils/enums.dart';
import 'custom_cached_network_image.dart';
import 'custom_error_widget.dart';
import 'custom_release _date.dart';
import 'custom_rich_text.dart';
import 'movie_details_background.dart';
import 'movies_recommendation.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
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
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: const CircleAvatar(
                          backgroundColor: Colors.black87,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 75, 16, 16),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 115.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  movie.title
                                                      .toString()
                                                      .split(':')[0],
                                                  style: theme
                                                      .textTheme.headlineLarge,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              TextButton.icon(
                                                onPressed: null,
                                                icon: const Icon(Icons.star),
                                                label: Text(
                                                  movie.voteAverage
                                                      .toStringAsFixed(1),
                                                  style: theme
                                                      .textTheme.headlineSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      AppStrings.releaseDate,
                                                      style: theme.textTheme
                                                          .headlineMedium,
                                                    ),
                                                    CustomReleaseDate(
                                                        releaseDate:
                                                            movie.releaseDate),
                                                  ],
                                                ),
                                                CustomRichText(
                                                  text1: AppStrings.duration,
                                                  text2: _showDuration(state
                                                      .movieDetails!.runtime),
                                                ),
                                                const SizedBox(height: 10),
                                                CustomRichText(
                                                  text1: AppStrings.genres,
                                                  text2:
                                                      _showGenres(movie.genres),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: Text(
                                                    AppStrings.overview,
                                                    style: theme.textTheme
                                                        .headlineMedium,
                                                  ),
                                                ),
                                                Text(
                                                  movie.overview,
                                                  style: theme
                                                      .textTheme.headlineSmall!
                                                      .copyWith(height: 1.2),
                                                ),
                                                _movieRecommendations(context),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 40,
                              child: Hero(
                                tag: '${movie.id}popular',
                                child: SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CustomCachedNetworkImage(
                                      imageUrl: ApiConstants.imageUrl(
                                        movie.backdropPath,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
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

  _movieRecommendations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            AppStrings.recommendations,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          buildWhen: (previous, current) =>
              previous.recommendationsState != current.recommendationsState,
          builder: (context, state) {
            switch (state.recommendationsState) {
              case RequestState.loading:
                return const CircularProgressIndicator();
              case RequestState.loaded:
                return GridView.builder(
                  padding: const EdgeInsets.only(top: 5, bottom: 7),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.7,
                    crossAxisCount: 3,
                  ),
                  itemCount: state.recommendations.length,
                  itemBuilder: (context, index) {
                    final Recommendation recommendation =
                        state.recommendations[index];
                    return MoviesRecommendations(
                      recommendation: recommendation,
                    );
                  },
                );
              case RequestState.error:
                return CustomErrorWidget(
                  errorMessage: state.recommendationsMessage,
                  errorMovieCategoryName: 'Recommendations',
                );
            }
          },
        ),
      ],
    );
  }
}
