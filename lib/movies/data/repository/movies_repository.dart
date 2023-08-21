import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/repository/base_movies_repository.dart';
import '../../domain/use cases/get_movie_detail_use_case.dart';
import '../../domain/use cases/get_recommendation_use_case.dart';
import '../data source/movie_remote_data_source.dart';

class MoviesRepository extends BaseMoviesRepository {
  BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MoviesRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await baseMovieRemoteDataSource.getNowPlayingMovies();

      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(
          ServerFailure.fromDioException(error: error),
        );
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final result = await baseMovieRemoteDataSource.getPopularMovies();
      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(
          ServerFailure.fromDioException(error: error),
        );
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await baseMovieRemoteDataSource.getTopRatedMovies();
      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(
          ServerFailure.fromDioException(error: error),
        );
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetail(
    MovieDetailsParameters parameters,
  ) async {
    try {
      final result =
          await baseMovieRemoteDataSource.getMovieDetails(parameters);
      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(
          ServerFailure.fromDioException(error: error),
        );
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters) async {
    try {
      final result =
          await baseMovieRemoteDataSource.getRecommendations(parameters);
      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(
          ServerFailure.fromDioException(error: error),
        );
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies() async {
    try {
      final result = await baseMovieRemoteDataSource.getUpcomingMovies();
      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(
          ServerFailure.fromDioException(error: error),
        );
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
