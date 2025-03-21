import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smokeless_movies/movie/moviedetails_model.dart';
import 'package:smokeless_movies/movielistmodels/latest_movies_model.dart';
import 'package:smokeless_movies/movielistmodels/popular_movies_model.dart';
import 'package:smokeless_movies/movielistmodels/top_rated_movies.dart';
import 'package:smokeless_movies/movielistmodels/upcoming-movies.dart';
import 'package:smokeless_movies/tvmodels/season_details_model.dart';
import 'package:smokeless_movies/searchmodels/movie_search_results_model.dart';
import 'package:smokeless_movies/searchmodels/multi_search_results_model.dart';
import 'package:smokeless_movies/searchmodels/person_search_results_model.dart';
import 'package:smokeless_movies/searchmodels/tv_search_results_model.dart';
import 'package:smokeless_movies/trendingmodels/trending_tv_results.dart';

import 'package:smokeless_movies/tvmodels/series_details_model.dart';
import 'package:smokeless_movies/utils/secrets.dart';
import 'package:smokeless_movies/trendingmodels/trending_movies_results.dart';

class TMDBAPIS {
  static String baseUrl = "https://api.themoviedb.org/3";

  // Search constants
  static String multiSearchEndpoint = '$baseUrl/search/multi';
  static String movieSearchEndpoint = '$baseUrl/search/movie';
  static String tvSearchEndpoint = '$baseUrl/search/tv';
  static String personSearchEndpoint = '$baseUrl/search/person';
  //trending constants
  static String trendingmovieEndpoint = '$baseUrl/trending/movie';
  static String trendingtvEndpoint = '$baseUrl/trending/tv';
  //Movie details constant
  static String moviedetailsEndpoint = '$baseUrl/movie/';
  //tvseries constant
  static String tvdetailsEndpoint = "$baseUrl/tv";
  static String seasondetailsEndpoint = "$baseUrl/tv";
  //movielist constants
  static String popularMoviesEndpoint = "$baseUrl/movie/popular";
  static String upcomingMoviesEndpoint = "$baseUrl/movie/now_playing";
  static String latestMoviesEndpoint = "$baseUrl/movie/top_rated";
  static String topRatedMoviesEndpoint = "$baseUrl/movie/upcoming";

  static Future<Map<String, dynamic>> callAPI(String url) async {
    log("url: $url");
    Map<String, dynamic> rawWeatherData;
    try {
      // Attempt to fetch data from the API
      final response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $TMDB_TOKEN'});
      if (response.statusCode != 200) {
        throw Exception('Failed to load $url. Status code: ${response.statusCode}');
      }

      // Attempt to decode the JSON response
      try {
        rawWeatherData = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e, stackTrace) {
        log("Error decoding JSON: $e\n$stackTrace");
        throw Exception("JSON decoding failed: $e");
      }
    } catch (error, stackTrace) {
      log("Error fetching $url: $error\n$stackTrace");
      rethrow;
    }
    return rawWeatherData;
  }

  static Future<MultiSearchResults> multiSearch(String query) async {
    String url = "$multiSearchEndpoint?query=$query";
    Map<String, dynamic> rawMap = await callAPI(url);

    // Now I have my multi-search results
    late MultiSearchResults results;
    // Attempt to convert the JSON into your model
    try {
      results = MultiSearchResults.fromMap(rawMap);
      log("Successfully parsed Multi-search results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during multi-search results model conversion: $e\n$stackTrace");
      throw Exception("Multi-search Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<MovieSearchResults> movieSearch(String query) async {
    String url = "$movieSearchEndpoint?query=$query";
    Map<String, dynamic> rawMap = await callAPI(url);

    // Now I have my movie results
    late MovieSearchResults results;
    // Attempt to convert the JSON into your model
    try {
      results = MovieSearchResults.fromMap(rawMap);
      log("Successfully parsed Movie results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during movie search results model conversion: $e\n$stackTrace");
      throw Exception("Movie Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<PersonSearchResults> personSearch(String query) async {
    String url = "$personSearchEndpoint?query=$query";
    Map<String, dynamic> rawMap = await callAPI(url);

    // Now I have my person results
    late PersonSearchResults results;
    // Attempt to convert the JSON into your model
    try {
      results = PersonSearchResults.fromMap(rawMap);
      log("Successfully parsed Person results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during Person search results model conversion: $e\n$stackTrace");
      throw Exception("Person Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<TvSearchResults> tvSearch(String query) async {
    String url = "$tvSearchEndpoint?query=$query";
    Map<String, dynamic> rawMap = await callAPI(url);

    // Now I have my person results
    late TvSearchResults results;
    // Attempt to convert the JSON into your model
    try {
      results = TvSearchResults.fromMap(rawMap);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during TV search results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<TrendingMoviesResults> trendingMovie() async {
    String url = "$trendingmovieEndpoint/week";
    Map<String, dynamic> rawMap = await callAPI(url);
    // Now I have my trending movie results
    late TrendingMoviesResults results;
    // Attempt to convert the JSON into your model
    try {
      results = TrendingMoviesResults.fromMap(rawMap);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during Trending movie results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<TrendingTvResults> trendingTvResults() async {
    String url = "$trendingtvEndpoint/week";
    Map<String, dynamic> rawMap = await callAPI(url);
    // Now I have my trending movie results
    late TrendingTvResults results;
    // Attempt to convert the JSON into your model
    try {
      results = TrendingTvResults.fromMap(rawMap);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during Trending tvseries results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<MovieDetails> movieDetailsResults(String id) async {
    String url = "$moviedetailsEndpoint/$id?append_to_response=credits,recommendations";
    Map<String, dynamic> rawMap = await callAPI(url);
    // Now I have my  movie results
    late MovieDetails results;
    // Attempt to convert the JSON into your model
    try {
      results = MovieDetails.fromMap(rawMap);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during  movie results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<SeriesDetails> tvSeriesDetails(String id) async {
    String url = "$tvdetailsEndpoint/$id?append_to_response=credits,recommendations";
    Map<String, dynamic> rawMap = await callAPI(url);
    // Now I have my tvseries results
    late SeriesDetails results;
    // Attempt to convert the JSON into your model
    try {
      results = SeriesDetails.fromMap(rawMap);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during series details results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<SeasonDetailsModel> tvSeasonDetails(String seriesId, String seasonNumber) async {
    String url = "$seasondetailsEndpoint/$seriesId/season/$seasonNumber";
    Map<String, dynamic> rawMap = await callAPI(url);
    // Now I have my tvseason results
    late SeasonDetailsModel results;
    // Attempt to convert the JSON into your model
    try {
      results = SeasonDetailsModel.fromMap(rawMap);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during season details results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<PopularMoviesModel> popularMovies() async {
    String url = popularMoviesEndpoint;
    Map<String, dynamic> rawMap = await callAPI(url);
    // Now I have my tvseason results
    late PopularMoviesModel results;
    // Attempt to convert the JSON into your model
    try {
      results = PopularMoviesModel.fromMap(rawMap);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during season details results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<LatestMoviesModel> latestMovies() async {
    String url = latestMoviesEndpoint;
    Map<String, dynamic> json = await callAPI(url);
    // Now I have my tvseason results
    late LatestMoviesModel results;
    // Attempt to convert the JSON into your model
    try {
      results = LatestMoviesModel.fromMap(json);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during season details results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<TopRatedMoviesModel> toprated() async {
    String url = topRatedMoviesEndpoint;
    Map<String, dynamic> json = await callAPI(url);
    // Now I have my tvseason results
    late TopRatedMoviesModel results;
    // Attempt to convert the JSON into your model
    try {
      results = TopRatedMoviesModel.fromMap(json);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during season details results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }

  static Future<UpcomingMoviesModel> upcomingMovies() async {
    String url = upcomingMoviesEndpoint;
    Map<String, dynamic> json = await callAPI(url);
    // Now I have my tvseason results
    late UpcomingMoviesModel results;
    // Attempt to convert the JSON into your model
    try {
      results = UpcomingMoviesModel.fromMap(json);
      log("Successfully parsed TV results data:");
    } catch (e, stackTrace) {
      log("Unexpected error during season details results model conversion: $e\n$stackTrace");
      throw Exception("TV Results Data conversion failed: $e");
    }
    return results;
  }
}
