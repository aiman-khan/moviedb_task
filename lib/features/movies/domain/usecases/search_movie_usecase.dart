import 'package:moviedb_task/features/movies/domain/entities/movie.dart';
import 'package:moviedb_task/features/movies/domain/repository/movies_repository.dart';
import 'package:moviedb_task/infrastructure/usecase.dart';
import 'package:moviedb_task/infrastructure/usecase_input.dart';
import 'package:moviedb_task/infrastructure/usecase_output.dart';
import 'package:injectable/injectable.dart';

class SearchMovieUsecaseInput extends Input {
  SearchMovieUsecaseInput({required this.page, required this.query});

  final int page;
  final String query;
}

class SearchMovieUsecaseOutput extends Output {
  final List<Movie> movies;

  SearchMovieUsecaseOutput({required this.movies});
}

@lazySingleton
class SearchMovieUsecase
    extends Usecase<SearchMovieUsecaseInput, SearchMovieUsecaseOutput> {
  final MovieRepository _movieRepository;

  SearchMovieUsecase({required MovieRepository movieRepository})
    : _movieRepository = movieRepository;

  @override
  Future<SearchMovieUsecaseOutput> call(SearchMovieUsecaseInput input) async {
    return await _movieRepository.searchMovie(input);
  }
}
