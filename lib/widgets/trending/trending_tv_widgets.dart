import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:smokeless_movies/trendingmodels/trending_tv_results.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smokeless_movies/pages/series_details_page.dart';

class TrendingTvWidgets extends StatelessWidget {
  const TrendingTvWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: FutureBuilder<TrendingTvResults>(
        future: TMDBAPIS.trendingTvResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed to load trending movies"));
          } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
            return const Center(child: Text("No trending movies available"));
          }

          List<Result> tvshows = snapshot.data!.results;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tvshows.length,
            itemBuilder: (context, index) {
              var tv = tvshows[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: OutlinedButton(
                  onPressed: () {
                    log('Clicked on ${tv.name}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesDetailsPage(id: tv.id.toString()),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 180,
                      width: 100,
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w154/${tv.posterPath}',
                            width: 100,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported,
                              color: Colors.black45,
                              size: 30,
                            ),
                          ),
                          Text(
                            "${tv.name}",
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
