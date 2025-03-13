import 'package:flutter/material.dart';
import 'package:smokeless_movies/searchmodels/multi_search_results_model.dart';
import 'package:smokeless_movies/utils/tmdbapis.dart';
import 'package:smokeless_movies/widgets/search/search_results_page.dart';

class SmokelessSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultsPage(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text("Enter a search query above"));
    }

    return FutureBuilder<MultiSearchResults>(
      future: TMDBAPIS.multiSearch(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error fetching your search results"));
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
              title: Text(
                item.title ?? item.originalTitle ?? "Title not found",
                style: TextStyle(
                  color: (item.title == null && item.originalTitle == null) ? Colors.grey : Colors.black,
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
    );
  }
}
