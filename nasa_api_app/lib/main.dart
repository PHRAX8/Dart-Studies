import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(NasaApiApp());

class NasaApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA API App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imageUrls = [];
  bool isLoading = false;

  Future<List<String>> fetchMarsRoverPhotos() async {
    final apiKey = 'yLoysKhp3V3bYae2BLGFEjKNTCWkCYmt8VGH2i1P';
    final apiUrl =
        'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> urls = [];
      for (var photo in data['photos']) {
        urls.add(photo['img_src']);
      }
      return urls;
    } else {
      throw Exception(
          'Failed to fetch Mars Rover photos: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMarsRoverPhotos().then((urls) {
      setState(() {
        imageUrls = urls;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch Mars Rover photos'),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NASA API App'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
    );
  }
}
