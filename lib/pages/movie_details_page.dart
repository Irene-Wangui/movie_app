import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smokeless_movies/controllers/media_controller.dart';
import 'package:smokeless_movies/movie/moviedetails_model.dart';
import 'package:smokeless_movies/pages/moviecastpage.dart';
import 'package:smokeless_movies/utils/firebase_apis.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';

import '../my_media_model/media_model.dart';

class MovieDetailsPage extends StatelessWidget {
  final String id;
  const MovieDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final MediaController mediaController = Get.put(MediaController());
    return SizedBox(
        height: 180,
        child: FutureBuilder<MovieDetails>(
            future: TMDBAPIS.movieDetailsResults(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loading
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load movie details"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text(" movie not available"));
              }
              MovieDetails moviedetails = snapshot.data!;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                extendBodyBehindAppBar: true,
                body: Stack(children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: CachedNetworkImage(
                        imageUrl: "https://image.tmdb.org/t/p/w780/${moviedetails.backdropPath}",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: (MediaQuery.of(context).size.height * 0.75 + 17),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: OverflowBar(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 110,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${moviedetails.title}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('${moviedetails.releaseDate!.year}'),
                                                  const SizedBox(width: 5),
                                                  const Text("."),
                                                  const SizedBox(width: 5),
                                                  Text('${moviedetails.runtime} min'),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Icon(Icons.star, color: Colors.yellow),
                                                  Text(moviedetails.voteAverage!.toStringAsFixed(1)),
                                                  // Spacer(),
                                                  GetBuilder(
                                                      init: MediaController(),
                                                      initState: (state) {
                                                        log("state mounted");
                                                        mediaController.fetchMediaDetails(
                                                            'movie', moviedetails.id.toString());
                                                      },
                                                      builder: (_) => IconButton(
                                                            onPressed: () async {
                                                              if (mediaController.isBookMarked.value) {
                                                                log("Is bookmarked");
                                                              }
                                                              log('should toogle bookmark');
                                                              //implement my media model
                                                              final media = MymediaModel(
                                                                id: "movie-${moviedetails.id}",
                                                                tmdbId: moviedetails.id.toString(),
                                                                title: moviedetails.title.toString(),
                                                                mediaType: 'movie',
                                                                posterPath: moviedetails.posterPath,
                                                                dateAdded: DateTime.now(),
                                                                releaseDate: moviedetails.releaseDate,
                                                              );
                                                              await mediaController.toggle(media);
                                                            },
                                                            icon: Icon(
                                                              mediaController.isBookMarked.value
                                                                  ? MdiIcons.bookmarkMinus
                                                                  : MdiIcons.bookmarkPlusOutline,
                                                              size: 24,
                                                            ),
                                                          ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(
                                      "Overview",
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(moviedetails.overview!),
                                    Column(
                                      children: [
                                        MovieCastPage(
                                          castList: moviedetails.credits!,
                                          resultsList: moviedetails.recommendations!,
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.95, -0.55),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        width: 120,
                        height: 180,
                        child: CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w154/${moviedetails.posterPath}',
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          width: double.infinity,
                          height: 160,
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            }));
  }
}
