import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../entities/recommendation.dart';
import '../use cases/get_movie_detail_use_case.dart';
import '../use cases/get_recommendation_use_case.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, List<Movie>>> getUpcomingMovies();

  Future<Either<Failure, MovieDetails>> getMovieDetail(
      MovieDetailsParameters parameters);

  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters);
}
