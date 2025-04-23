import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smokeless_movies/controllers/media_controller.dart';
import 'package:smokeless_movies/pages/series_details_page.dart';

class MyTvshowsPage extends StatelessWidget {
  const MyTvshowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaController mediaController = Get.put(MediaController());

    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarked Tvshows")),
      body: GetBuilder(
          init: mediaController,
          builder: (_) {
            return ListView.builder(
              itemCount: mediaController.myMedia.length,
              itemBuilder: (context, index) {
                final media = mediaController.myMedia[index];

                if (media.mediaType == "tv") {
                  final tv = media;
                  //log("https://image.tmdb.org/t/p/w200${movie.posterPath}");
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w200${tv.posterPath}",
                      fit: BoxFit.cover,
                      width: 50,
                      height: 75,
                      placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
                      errorWidget: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    title: Text(tv.title),
                    subtitle: Text("Release Date: ${tv.releaseDate?.year ?? 'N/A'}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        mediaController.toggle(tv);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeriesDetailsPage(id: tv.tmdbId),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }),
    );
  }
}
