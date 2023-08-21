import '../../domain/entities/genres.dart';

class GenresModel extends Genres {
  const GenresModel({
    required super.id,
    required super.name,
  });

  factory GenresModel.formJson(Map<String, dynamic> json) {
    return GenresModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
