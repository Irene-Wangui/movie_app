import 'package:flutter/material.dart';
import 'package:smokeless_movies/trendingmodels/trending_movies_results.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';

import 'package:smokeless_movies/widgets/medial_list_widget.dart';

class TrendingMoviesWidgets extends StatelessWidget {
  const TrendingMoviesWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrendingMoviesResults>(
      future: TMDBAPIS.trendingMovie(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Loading
        } else if (snapshot.hasError) {
          return const Center(child: Text("Failed to load trending movies"));
        } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return const Center(child: Text("No trending movies available"));
        }

        List<TrendingMovieItem> movies = snapshot.data!.results;
        return MediaList(
          items: movies
              .map(
                (e) => MiniMedia(
                    id: e.id.toString(),
                    mediaType: "movie",
                    posterpath: e.posterPath,
                    releaseDate: e.releaseDate,
                    overview: e.overview,
                    title: e.title),
              )
              .toList(),
        );
      },
    );
  }
}
