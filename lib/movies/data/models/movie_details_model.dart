import '../../domain/entities/movie_details.dart';
import 'genres_model.dart';

class MovieDetailsModels extends MovieDetails {
  const MovieDetailsModels({
    required super.id,
    required super.backdropPath,
    required super.posterPath,
    required super.genres,
    required super.title,
    required super.overview,
    required super.releaseDate,
    required super.runtime,
    required super.voteAverage,
  });

  factory MovieDetailsModels.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModels(
      id: json['id'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      genres: List<GenresModel>.from(
          json['genres'].map((e) => GenresModel.formJson(e))),
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}
