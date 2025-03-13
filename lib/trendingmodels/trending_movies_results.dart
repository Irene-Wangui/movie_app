// To parse this JSON data, do
//
//     final trendingMoviesResults = trendingMoviesResultsFromMap(jsonString);

import 'dart:convert';

TrendingMoviesResults trendingMoviesResultsFromMap(String str) => TrendingMoviesResults.fromMap(json.decode(str));

String trendingMoviesResultsToMap(TrendingMoviesResults data) => json.encode(data.toMap());

class TrendingMoviesResults {
  int page;
  List<TrendingMovieItem> results;
  int totalPages;
  int totalResults;

  TrendingMoviesResults({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingMoviesResults.fromMap(Map<String, dynamic> json) => TrendingMoviesResults(
        page: json["page"],
        results: List<TrendingMovieItem>.from(json["results"].map((x) => TrendingMovieItem.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class TrendingMovieItem {
  String? backdropPath;
  int id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  bool? adult;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  DateTime? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  TrendingMovieItem({
    this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory TrendingMovieItem.fromMap(Map<String, dynamic> json) => TrendingMovieItem(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        adult: json["adult"],
        originalLanguage: json["original_language"],
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "adult": adult,
        "original_language": originalLanguage,
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
