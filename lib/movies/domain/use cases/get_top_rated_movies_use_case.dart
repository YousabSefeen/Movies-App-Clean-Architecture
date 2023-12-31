import 'package:dartz/dartz.dart';

import '../../../core/base use cases/base_use_case.dart';
import '../../../core/errors/failure.dart';
import '../entities/movie.dart';
import '../repository/base_movies_repository.dart';

class GetTopRatedMoviesUseCase extends BaseUseCase<List<Movie>, NoParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetTopRatedMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async {
    return await baseMoviesRepository.getTopRatedMovies();
  }
}
