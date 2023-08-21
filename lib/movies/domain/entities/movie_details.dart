import 'package:equatable/equatable.dart';

import 'genres.dart';

class MovieDetails extends Equatable {
  final int id;
  final String backdropPath;
  final String posterPath;
  final List<Genres> genres;
  final String title;
  final String overview;
  final String releaseDate;

  final int runtime;
  final double voteAverage;

  const MovieDetails({
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genres,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
  });

  @override
  List<Object> get props => [
        id,
        backdropPath,
        posterPath,
        genres,
        title,
        overview,
        releaseDate,
        runtime,
        voteAverage,
      ];
}
