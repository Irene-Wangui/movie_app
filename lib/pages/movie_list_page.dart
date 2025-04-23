import 'package:flutter/material.dart';
import 'package:smokeless_movies/movie/movielistmodels/latest_movies_model.dart';
import 'package:smokeless_movies/movie/movielistmodels/popular_movies_model.dart';
import 'package:smokeless_movies/movie/movielistmodels/top_rated_movies.dart';
import 'package:smokeless_movies/movie/movielistmodels/upcoming-movies.dart';
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
          "Movie List Page",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Popular movies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
            child: Text(
              "TopRated movies",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
            child: Text(
              'Upcoming movies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
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

              final upcomingmovie = snapshot.data!.results;

              return MediaList(
                items: upcomingmovie
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
            child: Text(
              "Latest Movies",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
          ),
        ],
      ),
    );
  }
}
