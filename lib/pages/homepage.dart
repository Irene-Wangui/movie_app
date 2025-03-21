import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:smokeless_movies/pages/movie_details_page.dart';
import 'package:smokeless_movies/pages/movie_list_page.dart';

import 'package:smokeless_movies/searchmodels/multi_search_results_model.dart';
import 'package:smokeless_movies/trendingmodels/trending_movies_results.dart';
import 'package:smokeless_movies/trendingmodels/trending_tv_results.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';
import 'package:smokeless_movies/widgets/search/smokeless_search_delegate.dart';
import 'package:smokeless_movies/widgets/trending/trending_movies_widgets.dart';
import 'package:smokeless_movies/widgets/trending/trending_tv_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of movie categories
  final List<String> categories = [
    "Action",
    "Comedy",
    "Drama",
    "Horror",
    "Sci-Fi",
    "Romance",
    "Thriller",
    "Animation",
    "Mystery",
    "Fantasy",
    "Crime",
    "Adventure"
  ];
  //Trending tv and movieshows
  late Future<TrendingMoviesResults> trendingmovies;
  late Future<TrendingTvResults> trendingtv;

  @override
  void initState() {
    super.initState();
    trendingmovies = TMDBAPIS.trendingMovie();
    trendingtv = TMDBAPIS.trendingTvResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smokeless Movies')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(48, 0, 16, 0),
            child: ElevatedButton(
              onPressed: () async {
                log("Clicked search");
                MultiSearchResultItem res = await showSearch(
                  context: context,
                  delegate: SmokelessSearchDelegate(),
                );
                if (res.mediaType != null && res.mediaType == "movie") {
                  log("You have clicked a movie ${res.name ?? res.title ?? "no name/title"}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(id: res.id.toString()),
                    ),
                  );
                } else {
                  log("You have clicked a ${res.mediaType ?? "Unknown"} ${res.name ?? res.title ?? "no name/title"}");
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Search", style: TextStyle(color: Colors.black45)),
                  SizedBox(width: 150),
                  Icon(Icons.search, size: 20, color: Colors.black45),
                ],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 40,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((genre) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        log("Selected category: $genre");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        backgroundColor: Colors.grey.shade700,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(genre),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Trending Movies Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Trending Movies", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    log("Pressed View All");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListPage()));
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),

          TrendingMoviesWidgets(),

          //Trending Tvshows section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Trending Series", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    log("Pressed View All");
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListPage()));
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
          const TrendingTvWidgets(),
        ],
      ),
    );
  }
}
