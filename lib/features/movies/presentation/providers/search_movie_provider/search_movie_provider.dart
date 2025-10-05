import 'package:moviedb_task/core/utils/di/di.dart';
import 'package:moviedb_task/features/movies/domain/entities/movie.dart';
import 'package:moviedb_task/features/movies/domain/usecases/search_movie_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SearchMoviesController extends StateNotifier<AsyncValue<List<Movie>>> {
  SearchMoviesController(this.ref) : super(const AsyncData([]));

  final Ref ref;

  int _page = 1;
  bool _hasMore = true;
  String _currentQuery = "";
  final List<Movie> _movies = [];

  Future<void> searchMovies(String query, {bool loadMore = false}) async {
    if (query.isEmpty) return;

    if (!loadMore) {
      // new search
      state = const AsyncLoading();
      _movies.clear();
      _page = 1;
      _hasMore = true;
      _currentQuery = query;
    }

    if (loadMore && (!_hasMore || _currentQuery != query)) return;

    try {
      final input = SearchMovieUsecaseInput(query: _currentQuery, page: _page);
      final output = await sl<SearchMovieUsecase>()(input);

      if (output.movies.isEmpty) {
        _hasMore = false;
      }

      _movies.addAll(output.movies);
      _page++;

      state = AsyncData([..._movies]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final searchMoviesProvider =
    StateNotifierProvider<SearchMoviesController, AsyncValue<List<Movie>>>(
      (ref) => SearchMoviesController(ref),
    );
