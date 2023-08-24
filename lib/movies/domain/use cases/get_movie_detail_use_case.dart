import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/base use cases/base_use_case.dart';
import '../../../core/errors/failure.dart';
import '../entities/movie_details.dart';
import '../repository/base_movies_repository.dart';

class GetMovieDetailsUSeCase
    extends BaseUseCase<MovieDetails, MovieDetailsParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetMovieDetailsUSeCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, MovieDetails>> call(
    MovieDetailsParameters parameters,
  ) async {
    return await baseMoviesRepository.getMovieDetail(parameters);
  }
}

class MovieDetailsParameters extends Equatable {
  final int movieId;

  const MovieDetailsParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
