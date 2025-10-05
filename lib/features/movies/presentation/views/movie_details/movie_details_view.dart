import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_task/core/extensions/num.dart';
import 'package:moviedb_task/features/movies/domain/entities/movie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDetailsView extends StatelessWidget {
  final Movie movie;

  const MovieDetailsView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300.h,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                    ),
                  ),
                  background: CachedNetworkImage(
                    imageUrl: movie.posterPath ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: Icon(Icons.broken_image, size: 50.r),
                    ),
                  ),
                ),
              ),

              /// [Content]
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// [Title]
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      8.hb,

                      /// [Release date & rating row]
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),

                          4.wb,

                          Text(
                            movie.releaseDate ?? 'Unknown',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),

                          const Spacer(),

                          Icon(Icons.star, color: Colors.amber, size: 18.r),

                          4.wb,

                          Text(
                            movie.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      20.hb,

                      /// [Overview]
                      Text(
                        "Overview",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      8.hb,

                      Text(
                        movie.overview != null && movie.overview!.isNotEmpty
                            ? movie.overview!
                            : "No description available.",
                        style: TextStyle(fontSize: 15.sp, height: 1.4),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
