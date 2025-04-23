import 'package:flutter/material.dart';
import 'package:smokeless_movies/tv_list_models/popular_tv_shows_model.dart';
import 'package:smokeless_movies/tv_list_models/top_rated_tv_shows_model.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';
import 'package:smokeless_movies/widgets/medial_list_widget.dart';

class TvListPage extends StatelessWidget {
  const TvListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            "Tv List Page",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Popular Tvshows',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<PopularTvModel>(
            future: TMDBAPIS.popularTvshows(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loading
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load popular tv details"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No popular tv shows available"));
              }

              final populartv = snapshot.data!.results;

              return MediaList(
                items: populartv
                    .map(
                      (e) => MiniMedia(
                          id: e.id.toString(),
                          mediaType: "tv",
                          posterpath: e.posterPath,
                          releaseDate: e.firstAirDate,
                          title: e.name),
                    )
                    .toList(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Top Rated Tvshows",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<TopRatedTvModel>(
            future: TMDBAPIS.topRatedTvshows(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loading
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load toprated tv details"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No toprated tv shows available"));
              }

              final topratedTv = snapshot.data!.results;

              return MediaList(
                items: topratedTv
                    .map(
                      (e) => MiniMedia(
                          id: e.id.toString(),
                          mediaType: "tv",
                          posterpath: e.posterPath,
                          releaseDate: e.firstAirDate,
                          title: e.name),
                    )
                    .toList(),
              );
            },
          ),
        ]));
  }
}
