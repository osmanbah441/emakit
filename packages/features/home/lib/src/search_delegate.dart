import 'package:flutter/material.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Here you would trigger a real search (e.g., call a repository method)
    return Center(
      child: Text(
        'Searching for: "$query"',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // You can build a list of suggestions based on the query here
    // For now, we show a placeholder for image search and suggestions
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.image_search, size: 28),
            title: const Text('Search with an image'),
            subtitle: const Text('Upload a style you like'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image picker not implemented yet!'),
                ),
              );
            },
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Divider(),
          const SizedBox(height: 10),
          const Text('Suggestions will appear here...'),
        ],
      ),
    );
  }
}
