import 'package:moviedb_task/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:moviedb_task/features/movies/domain/usecases/search_movie_usecase.dart';
import 'package:moviedb_task/infrastructure/datasource.dart';

abstract class MovieRemoteDataSource extends DataSource {
  Future<GetUpcomingMoviesUsecaseOutput> getUpcomingMovies(
    GetUpcomingMoviesUsecaseInput input,
  );

  Future<SearchMovieUsecaseOutput> searchMovie(SearchMovieUsecaseInput input);
}
