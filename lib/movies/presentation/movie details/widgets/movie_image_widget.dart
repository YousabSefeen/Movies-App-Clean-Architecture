import 'package:flutter/material.dart';

import '../../../../core/common presentation/widgets/custom_cached_network_image.dart';
import '../../../../core/utils/api_constants.dart';
import '../../../domain/entities/movie_details.dart';

class MovieImageWidget extends StatelessWidget {
  final MovieDetails movie;

  const MovieImageWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
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
    );
  }
}
