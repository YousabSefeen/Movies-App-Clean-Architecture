import 'package:animate_do/animate_do.dart';
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

class PopularWidget extends StatelessWidget {
  const PopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) =>
          previous.popularState != current.popularState,
      builder: (context, state) {
        switch (state.popularState) {
          case RequestState.loading:
            return _customGridViewLoadingIndicator(width: width);

          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: width * 0.35,
                  mainAxisExtent: width * 0.36,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,

                  /// It is very important that someone else can get me an error
                ),
                itemCount: state.popularMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.popularMovies[index];
                  return InkWell(
                    splashColor: Colors.red,
                    onTap: () => Navigator.of(context).pushNamed(
                      MovieDetailsScreen.route,
                      arguments: movie.id,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          child: Hero(
                            tag: '${movie.id}popular',
                            child: CustomCachedNetworkImage(
                              imageUrl:
                                  ApiConstants.imageUrl(movie.backdropPath),
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: height * 0.13,
                          ),
                          padding: const EdgeInsets.all(7),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black87,
                          ),
                          child: Builder(builder: (context) {
                            return Text(
                              movie.title.toString().split(':')[0],
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          case RequestState.error:
            return CustomErrorWidget(
              errorMovieCategoryName: AppStrings.popular,
              errorMessage: state.popularMessageError,
            );
        }
      },
    );
  }
}

GridView _customGridViewLoadingIndicator({required double width}) {
  return GridView.builder(
    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
    physics: const BouncingScrollPhysics(),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: width * 0.35,
      mainAxisExtent: width * 0.36,
      childAspectRatio: 3 / 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,

      /// It is very important that someone else can get me an error
    ),
    itemCount: 100,
    itemBuilder: (context, index) =>
        CustomShimmer(height: double.infinity, width: width),
  );
}
