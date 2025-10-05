import 'package:flutter/material.dart';
import 'package:moviedb_task/features/movies/presentation/providers/get_upcoming_movies_provider/get_upcoming_movies_provider.dart';
import 'package:moviedb_task/features/movies/presentation/providers/search_movie_provider/search_movie_provider.dart';
import 'package:moviedb_task/features/movies/presentation/views/upcoming_movies/widgets/movie_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingMoviesView extends ConsumerStatefulWidget {
  const UpcomingMoviesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpcomingMoviesViewState();
}

class _UpcomingMoviesViewState extends ConsumerState<UpcomingMoviesView> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (_isSearching) {
          ref
              .read(searchMoviesProvider.notifier)
              .searchMovies(_searchController.text.trim(), loadMore: true);
        } else {
          ref.read(upcomingMoviesProvider.notifier).loadMovies(loadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moviesAsync = _isSearching
        ? ref.watch(searchMoviesProvider)
        : ref.watch(upcomingMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upcoming Movies",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// [Search]
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: "Search movies...",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                InkWell(
                  onTap: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      setState(() => _isSearching = true);
                      ref
                          .read(searchMoviesProvider.notifier)
                          .searchMovies(query);
                    } else {
                      setState(() => _isSearching = false);
                    }
                  },
                  borderRadius: BorderRadius.circular(30.r),
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          /// [Movies]
          Expanded(
            child: moviesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text(
                  "Something went wrong!\n${e.toString()}",
                  textAlign: TextAlign.center,
                ),
              ),
              data: (movies) {
                if (movies.isEmpty) {
                  return const Center(child: Text("No movies found."));
                }

                return GridView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(12.r),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(movie: movie);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
