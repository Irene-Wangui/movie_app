import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smokeless_movies/tvmodels/season_details_model.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';

class SeasonDetailsScreen extends StatefulWidget {
  final String seriesId;
  final List<int> seasons;

  const SeasonDetailsScreen({super.key, required this.seriesId, required this.seasons});

  @override
  SeasonDetailsScreenState createState() => SeasonDetailsScreenState();
}

class SeasonDetailsScreenState extends State<SeasonDetailsScreen> {
  int selectedSeason = 1;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.zero,
      ),
      SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: widget.seasons.map((season) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedSeason = season;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: selectedSeason == season ? Colors.purple : Colors.grey[300],
                  foregroundColor: selectedSeason == season ? Colors.white : Colors.black,
                ),
                child: Text("Season $season"),
              ),
            );
          }).toList(),
        ),
      ),
      Expanded(
        child: FutureBuilder<SeasonDetailsModel>(
          future: TMDBAPIS.tvSeasonDetails(widget.seriesId, selectedSeason.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Failed to load season details"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("Season not available"));
            }

            final season = snapshot.data!;

            return ListView.builder(
              itemCount: season.episodes!.length,
              itemBuilder: (context, index) {
                final episode = season.episodes![index];

                return SizedBox(
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w780${episode.stillPath}",
                      width: 145,
                      height: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported,
                        size: 30,
                        color: Colors.black45,
                      ),
                    ),
                    title: Column(
                      children: [
                        Text("Episode ${episode.episodeNumber}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          "${episode.name}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    ]);
  }
}
