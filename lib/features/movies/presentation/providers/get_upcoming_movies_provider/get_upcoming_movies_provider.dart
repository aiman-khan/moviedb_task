import 'package:moviedb_task/core/utils/di/di.dart';
import 'package:moviedb_task/features/movies/domain/entities/movie.dart';
import 'package:moviedb_task/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MovieController extends StateNotifier<AsyncValue<List<Movie>>> {
  MovieController(this.ref) : super(const AsyncLoading()) {
    loadMovies();
  }

  final Ref ref;
  int _page = 1;
  bool _hasMore = true;
  final List<Movie> _movies = [];

  List<Movie> get currentMovies => [..._movies];

  Future<void> loadMovies({bool loadMore = false}) async {
    if (loadMore && !_hasMore) return;

    if (!loadMore) {
      state = const AsyncLoading();
      _movies.clear();
      _page = 1;
    }

    try {
      final input = GetUpcomingMoviesUsecaseInput(page: _page);
      final output = await sl<GetUpcomingMoviesUsecase>()(input);

      final newMovies = output.movies;
      if (newMovies.isEmpty) _hasMore = false;

      _movies.addAll(newMovies);
      _page++;

      state = AsyncData([..._movies]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final upcomingMoviesProvider =
    StateNotifierProvider.autoDispose<MovieController, AsyncValue<List<Movie>>>(
      (ref) => MovieController(ref),
    );
