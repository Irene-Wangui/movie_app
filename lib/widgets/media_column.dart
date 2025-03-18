import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smokeless_movies/pages/movie_details_page.dart';
import 'package:smokeless_movies/pages/movie_list_page.dart';
import 'package:smokeless_movies/pages/series_details_page.dart';
import 'package:smokeless_movies/widgets/medial_list_widget.dart';

class MediaColumn extends StatelessWidget {
  final MiniMedia media;
  const MediaColumn({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 225,
        child: TextButton(
          onPressed: () {
            log("pressed this item");
            if (media.mediaType == 'movie') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(id: media.id),
                  ));
            } else if (media.mediaType == 'Tvshow') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeriesDetailsPage(id: media.id),
                  ));
            }
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w154${media.posterpath}',
                  width: 140,
                  height: 210,
                ),
              ),
              Text(
                media.title ?? "No title",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              if (media.releaseDate != null) Text(media.releaseDate!.year.toString()),
            ],
          ),
        ));
  }
}
