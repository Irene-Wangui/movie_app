// To parse this JSON data, do
//
//     final seasonDetails = seasonDetailsFromMap(jsonString);

import 'dart:convert';

SeasonDetailsModel seasonDetailsFromMap(String str) => SeasonDetailsModel.fromMap(json.decode(str));

String seasonDetailsToMap(SeasonDetailsModel data) => json.encode(data.toMap());

class SeasonDetailsModel {
  String? id;
  DateTime? airDate;
  List<Episode>? episodes;
  String? name;
  String? overview;
  int? seasonDetailsId;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  SeasonDetailsModel({
    this.id,
    this.airDate,
    this.episodes,
    this.name,
    this.overview,
    this.seasonDetailsId,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  factory SeasonDetailsModel.fromMap(Map<String, dynamic> json) => SeasonDetailsModel(
        id: json["_id"],
        airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodes: json["episodes"] == null ? [] : List<Episode>.from(json["episodes"]!.map((x) => Episode.fromMap(x))),
        name: json["name"],
        overview: json["overview"],
        seasonDetailsId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episodes": episodes == null ? [] : List<dynamic>.from(episodes!.map((x) => x.toMap())),
        "name": name,
        "overview": overview,
        "id": seasonDetailsId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}

class Episode {
  DateTime? airDate;
  int? episodeNumber;
  String? episodeType;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;
  double? voteAverage;
  int? voteCount;
  List<Crew>? crew;
  List<Crew>? guestStars;

  Episode({
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
    this.crew,
    this.guestStars,
  });

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
        airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        crew: json["crew"] == null ? [] : List<Crew>.from(json["crew"]!.map((x) => Crew.fromMap(x))),
        guestStars:
            json["guest_stars"] == null ? [] : List<Crew>.from(json["guest_stars"]!.map((x) => Crew.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x.toMap())),
        "guest_stars": guestStars == null ? [] : List<dynamic>.from(guestStars!.map((x) => x.toMap())),
      };
}

class Crew {
  String? job;
  String? department;
  String? creditId;
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? character;
  int? order;

  Crew({
    this.job,
    this.department,
    this.creditId,
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.character,
    this.order,
  });

  factory Crew.fromMap(Map<String, dynamic> json) => Crew(
        job: json["job"],
        department: json["department"],
        creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        character: json["character"],
        order: json["order"],
      );

  Map<String, dynamic> toMap() => {
        "job": job,
        "department": department,
        "credit_id": creditId,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "character": character,
        "order": order,
      };
}
