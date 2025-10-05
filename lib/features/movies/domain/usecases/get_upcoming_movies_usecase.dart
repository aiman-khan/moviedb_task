import 'package:moviedb_task/features/movies/domain/entities/movie.dart';
import 'package:moviedb_task/features/movies/domain/repository/movies_repository.dart';
import 'package:moviedb_task/infrastructure/usecase.dart';
import 'package:moviedb_task/infrastructure/usecase_input.dart';
import 'package:moviedb_task/infrastructure/usecase_output.dart';
import 'package:injectable/injectable.dart';

class GetUpcomingMoviesUsecaseInput extends Input {
  GetUpcomingMoviesUsecaseInput({required this.page});

  final int page;
}

class GetUpcomingMoviesUsecaseOutput extends Output {
  final List<Movie> movies;

  GetUpcomingMoviesUsecaseOutput({required this.movies});
}

@lazySingleton
class GetUpcomingMoviesUsecase
    extends
        Usecase<GetUpcomingMoviesUsecaseInput, GetUpcomingMoviesUsecaseOutput> {
  final MovieRepository _movieRepository;

  GetUpcomingMoviesUsecase({required MovieRepository movieRepository})
    : _movieRepository = movieRepository;

  @override
  Future<GetUpcomingMoviesUsecaseOutput> call(
    GetUpcomingMoviesUsecaseInput input,
  ) async {
    return await _movieRepository.getUpcomingMovies(input);
  }
}
