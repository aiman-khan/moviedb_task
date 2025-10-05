import 'package:moviedb_task/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    super.overview,
    super.posterPath,
    super.releaseDate,
    super.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    const String baseUrl = "https://image.tmdb.org/t/p/w500";

    return MovieModel(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? '',
      overview: json['overview'],
      posterPath: json['poster_path'] != null
          ? '$baseUrl${json['poster_path']}'
          : null,
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] != null)
          ? (json['vote_average'] as num).toDouble()
          : null,
    );
  }
}
