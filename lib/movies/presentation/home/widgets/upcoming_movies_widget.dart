import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/core/utils/app_routers.dart';

import '../../../../core/common presentation/widgets/custom_cached_network_image.dart';
import '../../../../core/common presentation/widgets/custom_error_widget.dart';
import '../../../../core/common presentation/widgets/custom_release_date.dart';
import '../../../../core/common presentation/widgets/custom_shimmer.dart';
import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/movie.dart';
import '../../movie details/screens/movie_details_screen.dart';
import '../controller/cubit/movies_cubit.dart';
import '../controller/states/movies_state.dart';

class UpcomingMoviesWidget extends StatelessWidget {
  const UpcomingMoviesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textContext = Theme.of(context).textTheme;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) =>
          previous.upcomingState != current.upcomingState,
      builder: (context, state) {
        switch (state.upcomingState) {
          case RequestState.loading:
            return _customListViewLoadingIndicator();
          case RequestState.loaded:
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: state.upcomingMovies.length,
              itemBuilder: (context, index) {
                final movie = state.upcomingMovies[index];
                return SizedBox(
                  height: height * 0.2,
                  child: Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => AppRouters.go(
                        context: context,
                        route: MovieDetailsScreen.route,
                        arguments: movie.id,
                      ),
                      child: Row(
                        children: [
                          _movieImage(width, movie),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: LayoutBuilder(
                                builder: (context, constraints) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: constraints.maxHeight * 0.3,
                                      child: FittedBox(
                                        child: Text(
                                          movie.title.toString().split(':')[0],
                                          style: textContext.titleSmall!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.29,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomReleaseDate(
                                            releaseDate: movie.releaseDate,
                                          ),
                                          TextButton.icon(
                                            onPressed: null,
                                            icon: const Icon(Icons.star),
                                            label: Text(
                                              movie.voteAverage
                                                  .toStringAsFixed(1),
                                              style: textContext.headlineSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        movie.overview,
                                        style: textContext.bodyLarge,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          case RequestState.error:
            return CustomErrorWidget(
              errorMovieCategoryName: AppStrings.upcomingMovies,
              errorMessage: state.upcomingMessageError,
            );
        }
      },
    );
  }

  SizedBox _movieImage(double width, Movie movie) {
    return SizedBox(
      width: width * 0.35,
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          child: CustomCachedNetworkImage(
            imageUrl: ApiConstants.imageUrl(
              movie.backdropPath,
            ),
          )),
    );
  }
}

_customListViewLoadingIndicator() {
  return ListView.builder(
    padding: EdgeInsets.zero,
    physics: const BouncingScrollPhysics(),
    itemCount: 50,
    itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.all(10),
        child: CustomShimmer(height: 130, width: double.infinity)),
  );
}
