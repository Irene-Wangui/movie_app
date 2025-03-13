// To parse this JSON data, do
//
//     final trendingTvResults = trendingTvResultsFromMap(jsonString);

import 'dart:convert';

TrendingTvResults trendingTvResultsFromMap(String str) => TrendingTvResults.fromMap(json.decode(str));

String trendingTvResultsToMap(TrendingTvResults data) => json.encode(data.toMap());

class TrendingTvResults {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TrendingTvResults({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingTvResults.fromMap(Map<String, dynamic> json) => TrendingTvResults(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
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

class Result {
  String? backdropPath;
  int id;
  String? name;
  String? originalName;
  String? overview;
  String? posterPath;
  String? mediaType;
  bool? adult;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  DateTime? firstAirDate;
  double? voteAverage;
  int? voteCount;
  List<String>? originCountry;

  Result({
    this.backdropPath,
    required this.id,
    this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        adult: json["adult"],
        originalLanguage: json["original_language"],
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "adult": adult,
        "original_language": originalLanguage,
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
      };
}
