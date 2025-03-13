import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smokeless_movies/pages/series_details_page.dart';
import 'package:smokeless_movies/tvmodels/series_details_model.dart';

class SeriesCastPage extends StatelessWidget {
  final Credits castList;
  final Recommendations resultsList;

  const SeriesCastPage({
    super.key,
    required this.castList,
    required this.resultsList,
  });

  @override
  Widget build(BuildContext context) {
    List<Cast> cast = castList.cast!;
    List<Cast> crew = castList.crew!;
    List<Result> recommendationResult = resultsList.results!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Cast",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (context, index) {
                var castitem = cast[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      log('Clicked on ${castitem.name}');
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: SizedBox(
                      height: 180,
                      width: 100,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w200${castitem.profilePath}',
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          Text(
                            "${castitem.name}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Crew",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: crew.length,
                itemBuilder: (context, index) {
                  var crewitem = crew[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        log('Clicked on ${crewitem.name}');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: 'https://image.tmdb.org/t/p/w200${crewitem.profilePath}',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                ),
                              ),
                            ),
                            Text(
                              "${crewitem.name}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Recommendations",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendationResult.length,
                itemBuilder: (context, index) {
                  var resultitem = recommendationResult[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        log('Clicked on ${resultitem.name}');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SeriesDetailsPage(id: resultitem.id.toString())));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: 'https://image.tmdb.org/t/p/w154${resultitem.posterPath}',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            Text(
                              resultitem.name!,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
