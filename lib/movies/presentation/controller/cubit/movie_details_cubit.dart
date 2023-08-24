import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/use cases/get_movie_detail_use_case.dart';
import '../../../domain/use cases/get_recommendation_use_case.dart';
import '../states/movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUSeCase getMovieDetailsUSeCase;
  final RecommendationUseCase getRecommendationUseCase;

  MovieDetailsCubit({
    required this.getMovieDetailsUSeCase,
    required this.getRecommendationUseCase,
  }) : super(const MovieDetailsState());

  FutureOr<void> getMovieDetails({required int movieId}) async {
    final response =
        await getMovieDetailsUSeCase(MovieDetailsParameters(movieId: movieId));

    response.fold(
        (l) => emit(state.copyWith(
              movieDetailsState: RequestState.error,
              movieDetailsMessage: l.errorMessage,
            )),
        (r) => emit(state.copyWith(
              movieDetails: r,
              movieDetailsState: RequestState.loaded,
            )));
  }

  FutureOr<void> getRecommendation({required int movieId}) async {
    final response = await getRecommendationUseCase(
        RecommendationParameters(movieId: movieId));
    response.fold(
        (l) => emit(state.copyWith(
              recommendationsState: RequestState.error,
              recommendationsMessage: l.errorMessage,
            )),
        (r) => emit(state.copyWith(
              recommendations: r,
              recommendationsState: RequestState.loaded,
            )));
  }
}
