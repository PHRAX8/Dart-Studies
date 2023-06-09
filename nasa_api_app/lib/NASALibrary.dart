import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NASALibrary extends StatefulWidget {
  @override
  _NASALibraryState createState() => _NASALibraryState();
}

class _NASALibraryState extends State<NASALibrary> {
  List<dynamic> imageResults = [];
  TextEditingController _searchController = TextEditingController();

  void searchImages(String query) async {
    final apiUrl = 'https://images-api.nasa.gov/search?q=$query';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['collection']['items'] ?? [];
      setState(() {
        imageResults = items;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch image data'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NASA Image Library'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Images',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Search'),
                  onPressed: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      searchImages(query);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: imageResults.isNotEmpty
                ? ListView.builder(
                    itemCount: imageResults.length,
                    itemBuilder: (context, index) {
                      final item = imageResults[index];
                      final links = item['links'] ?? [];
                      final imageUrl = links.isNotEmpty ? links[0]['href'] : '';
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                errorBuilder: (context, error, stackTrace) {
                                  return Text('Failed to load image');
                                },
                              )
                            : Container(),
                      );
                    },
                  )
                : Center(
                    child: Text('No Images Found'),
                  ),
          ),
        ],
      ),
    );
  }
}
