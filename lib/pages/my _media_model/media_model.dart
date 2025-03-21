import 'package:uuid/uuid.dart';

class MymediaModel {
  final String tmdbId;
  final String id;
  String? uid;
  final String title;
  final String mediaType;
  final String? posterPath;
  final DateTime? dateAdded;
  final DateTime? releaseDate;

  MymediaModel({
    this.uid,
    required this.tmdbId,
    required this.id,
    required this.title,
    required this.mediaType,
    this.posterPath,
    this.dateAdded,
    this.releaseDate,
  });

  factory MymediaModel.fromMap(Map<String, dynamic> json) => MymediaModel(
        tmdbId: json['tmdbId'],
        id: json['id'],
        uid: json['uid'],
        title: json['title'],
        mediaType: json['mediaType'],
        posterPath: json['poster path'],
        dateAdded: json['dateAdded'] == null ? null : DateTime.tryParse(json['dateAdded']),
        releaseDate: json['releaseDate'] == null ? null : DateTime.tryParse(json['releaseDate']),
      );
  Map<String, dynamic> toMap() => {
        "uid": uid,
        "id": id,
        "tmdbId": tmdbId,
        "title": title,
        "mediaType": mediaType,
        "posterpath": posterPath,
        "dateAdded": dateAdded?.toIso8601String(),
        "releaseDate": releaseDate?.toIso8601String(),
      };
}
