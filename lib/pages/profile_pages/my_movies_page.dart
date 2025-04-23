import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smokeless_movies/controllers/media_controller.dart';
import 'package:smokeless_movies/pages/movie_details_page.dart';

class MyMoviesPage extends StatelessWidget {
  const MyMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaController mediaController = Get.put(MediaController());

    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarked Movies")),
      body: GetBuilder(
          init: mediaController,
          builder: (_) {
            return ListView.builder(
              itemCount: mediaController.myMedia.length,
              itemBuilder: (context, index) {
                final media = mediaController.myMedia[index];

                if (media.mediaType == "movie") {
                  final movie = media;
                  //log("https://image.tmdb.org/t/p/w200${movie.posterPath}");
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                      fit: BoxFit.cover,
                      width: 50,
                      height: 75,
                      placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
                      errorWidget: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    title: Text(movie.title),
                    subtitle: Text("Release Date: ${movie.releaseDate?.year ?? 'N/A'}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        mediaController.toggle(movie);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsPage(id: movie.tmdbId),
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
