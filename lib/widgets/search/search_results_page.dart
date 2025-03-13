import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smokeless_movies/searchmodels/multi_search_results_model.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late Future<MultiSearchResults> multiResults;

  @override
  void initState() {
    super.initState();
    multiResults = TMDBAPIS.multiSearch(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: ElevatedButton(
                  onPressed: () {
                    log("All clicked");
                    setState(() {
                      multiResults = TMDBAPIS.multiSearch(widget.query);
                    });
                  },
                  child: Text("All"),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<MultiSearchResults>(
              future: multiResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error fetching results"));
                }
                final data = snapshot.data;
                if (data == null || data.results.isEmpty) {
                  return Center(child: Text("No locations found"));
                }
                final results = data.results;

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final item = results[index];
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: "https://image.tmdb.org/t/p/w200/${item.posterPath}",
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      title: Text(
                        item.name ?? item.originalName ?? item.title ?? item.originalTitle ?? "Title not found",
                        style: TextStyle(
                          color: (item.name == null &&
                                  item.originalName == null &&
                                  item.title == null &&
                                  item.originalTitle == null)
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      subtitle: Row(children: [if (item.mediaType != null) Text(item.mediaType!)]),
                      onTap: () {
                        Navigator.of(context).pop(item);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
