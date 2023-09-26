import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/core/utils/app_routers.dart';

import '../../../../core/common presentation/widgets/custom_cached_network_image.dart';
import '../../../../core/common presentation/widgets/custom_error_widget.dart';
import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/recommendation.dart';
import '../controller/cubit/movie_details_cubit.dart';
import '../controller/states/movie_details_state.dart';
import '../screens/movie_details_screen.dart';

class MoviesRecommendationsWidget extends StatelessWidget {
  const MoviesRecommendationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
                    final recommendation = state.recommendations[index];
                    return _movie(
                      context: context,
                      theme: theme,
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

  FadeInUp _movie({
    required BuildContext context,
    required ThemeData theme,
    required Recommendation recommendation,
  }) {
    return FadeInUp(
      from: 20,
      duration: const Duration(milliseconds: 500),
      child: recommendation.backdropPath != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: InkWell(
                onTap: () => AppRouters.goAndReplacement(
                  context: context,
                  route: MovieDetailsScreen.route,
                  arguments: recommendation.id,
                ),
                child: CustomCachedNetworkImage(
                  imageUrl: ApiConstants.imageUrl(recommendation.backdropPath!),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  AppStrings.noImage,
                  style: theme.textTheme.headlineSmall!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
