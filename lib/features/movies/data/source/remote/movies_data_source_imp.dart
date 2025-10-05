import 'package:moviedb_task/core/constants/api_endpoints.dart';
import 'package:moviedb_task/core/helpers/network_call_helper/network_call_helper.dart';
import 'package:moviedb_task/core/utils/exceptions/exceptions.dart';
import 'package:moviedb_task/features/movies/data/models/movie/movie_model.dart';
import 'package:moviedb_task/features/movies/domain/data/movies_remote_data_source.dart';
import 'package:moviedb_task/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:moviedb_task/features/movies/domain/usecases/search_movie_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: MovieRemoteDataSource)
class AuthRemoteDataSourceImp implements MovieRemoteDataSource {
  final Logger _logger;
  final NetworkCallHelper _networkCallHelper;

  AuthRemoteDataSourceImp({
    required Logger logger,
    required NetworkCallHelper networkCallHelper,
  }) : _logger = logger,
       _networkCallHelper = networkCallHelper;

  @override
  Future<GetUpcomingMoviesUsecaseOutput> getUpcomingMovies(
    GetUpcomingMoviesUsecaseInput input,
  ) async {
    try {
      final response = await _networkCallHelper.get(
        ApiEndpoints.upcomingMovies,
        params: {'page': input.page},
        headers: {'Authorization': 'Bearer ${ApiEndpoints.apiKey}'},
      );

      final results = response['results'] as List<dynamic>;
      final movies = results.map((json) => MovieModel.fromJson(json)).toList();
      return GetUpcomingMoviesUsecaseOutput(movies: movies);
    } catch (e, stack) {
      _logger.e("Error fetching upcoming movies, $stack");
      throw SomethingWentWrongException(message: e.toString());
    }
  }

  @override
  Future<SearchMovieUsecaseOutput> searchMovie(
    SearchMovieUsecaseInput input,
  ) async {
    try {
      final response = await _networkCallHelper.get(
        ApiEndpoints.searchMovie,
        params: {'page': input.page, 'query': input.query},
        headers: {'Authorization': 'Bearer ${ApiEndpoints.apiKey}'},
      );

      final results = response['results'] as List<dynamic>;
      final movies = results.map((json) => MovieModel.fromJson(json)).toList();
      return SearchMovieUsecaseOutput(movies: movies);
    } catch (e, stack) {
      _logger.e("Error fetching upcoming movies, $stack");
      throw SomethingWentWrongException(message: e.toString());
    }
  }
}
