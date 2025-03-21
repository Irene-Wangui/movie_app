import 'package:flutter/material.dart';
import 'package:smokeless_movies/movielistmodels/popular_movies_model.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';
import 'package:smokeless_movies/widgets/medial_list_widget.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text("Movie List Page"),
        ),
        body: ListView(children: [
          FutureBuilder<PopularMoviesModel>(
            future: TMDBAPIS.popularMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loading
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load popular movie details"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No popular movies available"));
              }

              final popularMovie = snapshot.data!.results;

              return MediaList(
                items: popularMovie
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
          ),
        ]));
  }
}
