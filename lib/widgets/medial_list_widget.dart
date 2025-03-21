import 'package:flutter/material.dart';
import 'package:smokeless_movies/widgets/media_column.dart';

//class minimedia
class MiniMedia {
  final String id;
  final String mediaType;
  final String? title;
  final String? overview;
  final String? posterpath;
  final DateTime? releaseDate;
  const MiniMedia({
    required this.id,
    required this.mediaType,
    this.title,
    this.releaseDate,
    this.posterpath,
    this.overview,
  });
}

class MediaList extends StatelessWidget {
  final List<MiniMedia> items;
  const MediaList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 250, minHeight: 200),
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [...items.map((e) => MediaColumn(media: e))]),
        ),
      ],
    );
  }
}
