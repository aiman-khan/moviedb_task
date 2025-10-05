import 'package:moviedb_task/core/utils/router/paths.dart';
import 'package:moviedb_task/features/movies/domain/entities/movie.dart';
import 'package:moviedb_task/features/movies/presentation/views/movie_details/movie_details_view.dart';
import 'package:moviedb_task/features/movies/presentation/views/upcoming_movies/upcoming_movies_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePaths.upcomingMovies,
      builder: (context, state) {
        return const UpcomingMoviesView();
      },
    ),
    GoRoute(
      path: RoutePaths.movieDetails,
      builder: (context, state) {
        final data = state.extra as Movie;
        return MovieDetailsView(movie: data);
      },
    ),
  ],
);
