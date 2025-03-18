import 'package:flutter/material.dart';
import 'package:smokeless_movies/trendingmodels/trending_tv_results.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';

import 'package:smokeless_movies/widgets/medial_list_widget.dart';

class TrendingTvWidgets extends StatelessWidget {
  const TrendingTvWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrendingTvResults>(
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
        return MediaList(
          items: tvshows
              .map(
                (e) => MiniMedia(
                    id: e.id.toString(),
                    mediaType: "Tvshow",
                    posterpath: e.posterPath,
                    releaseDate: e.firstAirDate,
                    overview: e.overview,
                    title: e.name),
              )
              .toList(),
        );
      },
    );
  }
}
