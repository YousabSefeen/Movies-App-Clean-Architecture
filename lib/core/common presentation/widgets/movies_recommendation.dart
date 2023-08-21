import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../movies/domain/entities/recommendation.dart';
import '../../utils/api_constants.dart';
import '../../utils/app_strings.dart';
import '../screens/movie_details_screen.dart';
import 'custom_cached_network_image.dart';

class MoviesRecommendations extends StatelessWidget {
  final Recommendation recommendation;

  const MoviesRecommendations({required this.recommendation, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return FadeInUp(
      from: 20,
      duration: const Duration(milliseconds: 500),
      child: recommendation.backdropPath != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: InkWell(
                onTap: () => Navigator.of(context).pushReplacementNamed(
                  MovieDetailsScreen.route,
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
