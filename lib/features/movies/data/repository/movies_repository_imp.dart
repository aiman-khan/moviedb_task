import 'package:moviedb_task/features/movies/domain/data/movies_remote_data_source.dart';
import 'package:moviedb_task/features/movies/domain/repository/movies_repository.dart';
import 'package:moviedb_task/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:moviedb_task/features/movies/domain/usecases/search_movie_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _movieRemoteDataSource;

  MovieRepositoryImpl({required MovieRemoteDataSource movieRemoteDataSource})
    : _movieRemoteDataSource = movieRemoteDataSource;

  @override
  Future<GetUpcomingMoviesUsecaseOutput> getUpcomingMovies(
    GetUpcomingMoviesUsecaseInput input,
  ) async {
    return await _movieRemoteDataSource.getUpcomingMovies(input);
  }

  @override
  Future<SearchMovieUsecaseOutput> searchMovie(SearchMovieUsecaseInput input) {
    return _movieRemoteDataSource.searchMovie(input);
  }
}
