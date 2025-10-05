import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_task/core/utils/router/paths.dart';
import 'package:moviedb_task/features/movies/domain/entities/movie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(RoutePaths.movieDetails, extra: movie);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            /// [Poster]
            CachedNetworkImage(
              imageUrl: movie.posterPath ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180.h,
              placeholder: (context, url) => Container(
                height: 180.h,
                color: Colors.grey.shade300,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 180.h,
                color: Colors.grey.shade200,
                child: Icon(Icons.broken_image, size: 40.r),
              ),
            ),

            Container(
              height: 180.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            /// [Movie title]
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
