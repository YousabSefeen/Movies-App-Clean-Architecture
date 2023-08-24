import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/utils/api_constants.dart';
import '../../domain/use cases/get_movie_detail_use_case.dart';
import '../../domain/use cases/get_recommendation_use_case.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';
import '../models/recommendation_model.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<List<MovieModel>> getUpcomingMovies();

  Future<MovieDetailsModels> getMovieDetails(MovieDetailsParameters parameters);

  Future<List<RecommendationModel>> getRecommendations(
      RecommendationParameters parameters);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await Dio().get(ApiConstants.nowPlayingMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await Dio().get(ApiConstants.popularMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    final response = await Dio().get(ApiConstants.upComingMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await Dio().get(ApiConstants.topRatedMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<MovieDetailsModels> getMovieDetails(
    MovieDetailsParameters parameters,
  ) async {
    final response =
        await Dio().get(ApiConstants.movieDetailsPath(parameters.movieId));

    if (response.statusCode == 200) {
      return MovieDetailsModels.fromJson(response.data);
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendations(
      RecommendationParameters parameters) async {
    final response =
        await Dio().get(ApiConstants.recommendationPath(parameters.movieId));

    if (response.statusCode == 200) {
      return List<RecommendationModel>.from(
        (response.data['results'] as List).map(
          (e) => RecommendationModel.fromJson(e),
        ),
      );
    } else {
      throw ServerFailure(response.data);
    }
  }
}
