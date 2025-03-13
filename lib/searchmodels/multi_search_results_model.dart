// To parse this JSON data, do
//
//     final multiSearchResults = multiSearchResultsFromMap(jsonString);

import 'dart:convert';

MultiSearchResults multiSearchResultsFromMap(String str) => MultiSearchResults.fromMap(json.decode(str));

String multiSearchResultsToMap(MultiSearchResults data) => json.encode(data.toMap());

class MultiSearchResults {
  int page;
  List<MultiSearchResultItem> results;
  int totalPages;
  int totalResults;

  MultiSearchResults({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MultiSearchResults.fromMap(Map<String, dynamic> json) => MultiSearchResults(
        page: json["page"],
        results: List<MultiSearchResultItem>.from(json["results"].map((x) => MultiSearchResultItem.fromMap(x))),
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

class MultiSearchResultItem {
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
  String? name;
  String? originalName;
  int? gender;
  String? knownForDepartment;
  String? profilePath;
  List<MultiSearchResultItem>? knownFor;
  DateTime? firstAirDate;
  List<String>? originCountry;

  MultiSearchResultItem({
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
    this.name,
    this.originalName,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    this.knownFor,
    this.firstAirDate,
    this.originCountry,
  });

  factory MultiSearchResultItem.fromMap(Map<String, dynamic> json) => MultiSearchResultItem(
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
        releaseDate: json["release_date"] == null ? null : DateTime.tryParse(json["release_date"]),
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
        gender: json["gender"],
        knownForDepartment: json["known_for_department"],
        profilePath: json["profile_path"],
        knownFor: json["known_for"] == null
            ? []
            : List<MultiSearchResultItem>.from(json["known_for"]!.map((x) => MultiSearchResultItem.fromMap(x))),
        firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
        originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
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
        "name": name,
        "original_name": originalName,
        "gender": gender,
        "known_for_department": knownForDepartment,
        "profile_path": profilePath,
        "known_for": knownFor == null ? [] : List<dynamic>.from(knownFor!.map((x) => x.toMap())),
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
      };
}
