import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/base use cases/base_use_case.dart';
import '../../../core/errors/failure.dart';import '../entities/recommendation.dart';
import '../repository/base_movies_repository.dart';

class RecommendationUseCase
    extends BaseUseCase<List<Recommendation>, RecommendationParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  RecommendationUseCase({required this.baseMoviesRepository});

  @override
  Future<Either<Failure, List<Recommendation>>> call(
      RecommendationParameters parameters) async {
    return await baseMoviesRepository.getRecommendation(parameters);
  }
}

class RecommendationParameters extends Equatable {
  final int movieId;

  const RecommendationParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
