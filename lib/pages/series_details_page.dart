import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smokeless_movies/pages/season_details_page.dart';
import 'package:smokeless_movies/pages/series_cast_page.dart';
import 'package:smokeless_movies/tvmodels/series_details_model.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';

class SeriesDetailsPage extends StatelessWidget {
  final String id;
  SeriesDetailsPage({super.key, required this.id});
  final List<int> seasonsList = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 180,
        child: FutureBuilder<SeriesDetails>(
            future: TMDBAPIS.tvSeriesDetails(
              id,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loading
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load series details"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("series not available"));
              }
              SeriesDetails seriesDetails = snapshot.data!;

              return DefaultTabController(
                length: 2,
                child: Scaffold(
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
                          imageUrl: "https://image.tmdb.org/t/p/w780/${seriesDetails.backdropPath}",
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
                        child: ListView(padding: EdgeInsets.zero, children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 130,
                                      height: 100,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${seriesDetails.name}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text('${seriesDetails.firstAirDate!.year}'),
                                            const Text("."),
                                            const SizedBox(width: 5),
                                            Row(
                                              children: [
                                                Text('${seriesDetails.numberOfSeasons}seasons'),
                                                const SizedBox(width: 5),
                                                Text("${seriesDetails.numberOfEpisodes}episodes"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.yellow),
                                            Text(seriesDetails.voteAverage!.toStringAsFixed(1)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const TabBar(
                                tabs: [
                                  Tab(text: "Details"),
                                  Tab(text: "Seasons"),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: TabBarView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Text(
                                                  "Overview",
                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(seriesDetails.overview!),
                                                Column(
                                                  children: [
                                                    SeriesCastPage(
                                                      castList: seriesDetails.credits!,
                                                      resultsList: seriesDetails.recommendations!,
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SeasonDetailsScreen(
                                      seriesId: seriesDetails.id!.toString(),
                                      seasons:
                                          Iterable<int>.generate(seriesDetails.numberOfSeasons!, (i) => i + 1).toList(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
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
                            imageUrl: 'https://image.tmdb.org/t/p/w154/${seriesDetails.posterPath}',
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            width: double.infinity,
                            height: 160,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            }));
  }
}
