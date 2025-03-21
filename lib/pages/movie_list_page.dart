import 'package:flutter/material.dart';
import 'package:smokeless_movies/movielistmodels/latest_movies_model.dart';
import 'package:smokeless_movies/movielistmodels/popular_movies_model.dart';
import 'package:smokeless_movies/movielistmodels/top_rated_movies.dart';
import 'package:smokeless_movies/movielistmodels/upcoming-movies.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';
import 'package:smokeless_movies/widgets/medial_list_widget.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          "Movie List Page,",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Text('Popular movies'),
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
          /*  Padding(padding: EdgeInsets.all(16)),
          FutureBuilder<UpcomingMoviesModel>(
            future: TMDBAPIS.upcomingMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loading
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load popular movie details"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No popular movies available"));
              }

              List<Result>? upcomingmovie = snapshot.data!.results;

              return MediaList(
                items: upcomingMovie
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
          ), */
          Padding(padding: EdgeInsets.all(16)),
          Text(
            "Top Rated movies",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          FutureBuilder<TopRatedMoviesModel>(
            future: TMDBAPIS.toprated(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loading
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load popular movie details"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No popular movies available"));
              }

              final topratedMovie = snapshot.data!.results;

              return MediaList(
                items: topratedMovie
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
          /*  Padding(padding: EdgeInsets.all(16)),
          Text(
            "Latest Movies",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          FutureBuilder<LatestMoviesModel>(
            future: TMDBAPIS.latestMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load popular movie details"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No popular movies available"));
              }

              final latestMovie = snapshot.data!.results;

              return MediaList(
                items: latestMovie
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
          ), */
        ],
      ),
    );
  }
}
