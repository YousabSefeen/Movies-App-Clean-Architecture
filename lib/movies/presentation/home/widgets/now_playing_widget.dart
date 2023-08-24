import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common presentation/widgets/custom_cached_network_image.dart';
import '../../../../core/common presentation/widgets/custom_error_widget.dart';
import '../../../../core/common presentation/widgets/custom_shimmer.dart';
import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';

import '../../movie details/screens/movie_details_screen.dart';
import '../controller/cubit/movies_cubit.dart';
import '../controller/states/movies_state.dart';

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) =>
          previous.nowPlayingState != current.nowPlayingState,
      builder: (BuildContext context, state) {
        switch (state.nowPlayingState) {
          case RequestState.loading:
            return CustomShimmer(
              height: height * 0.2,
              width: double.infinity,
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,

                  height: height * 0.22,

                  viewportFraction: 1.0,
                  // viewportFraction= Each item occupies 100% of the viewport width
                ),
                items: state.nowPlayingMovies
                    .map(
                      (movie) => GestureDetector(
                        key: const Key(AppStrings.openMovieDetails),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            MovieDetailsScreen.route,
                            arguments: movie.id,
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    // fromLTRB
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0, 0.03, 0.3, 1],
                                ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: Hero(
                                tag: movie.id,
                                child: CustomCachedNetworkImage(
                                  imageUrl:
                                      ApiConstants.imageUrl(movie.backdropPath),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                nowPlayingText(context),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    movie.title.toString().split(':')[0],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          case RequestState.error:
            return CustomErrorWidget(
              errorMovieCategoryName: 'now playing movies',
              errorMessage: state.nowPlayingMessageError,
            );
        }
      },
    );
  }

  Container nowPlayingText(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black54,
      ),
      child: TextButton.icon(
          onPressed: null,
          icon: const Icon(
            Icons.circle,
            color: Colors.green,
          ),
          label: Text(
            AppStrings.nowPlaying,
            style: TextStyle(
                fontSize: width * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.w800),
          )),
    );
  }
}
