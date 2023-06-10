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
      home: MarsRoverScreen(),
    );
  }
}

class MarsRoverScreen extends StatefulWidget {
  @override
  _MarsRoverScreenState createState() => _MarsRoverScreenState();
}

class _MarsRoverScreenState extends State<MarsRoverScreen> {
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
    setState(() {
      isLoading = true;
    });
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
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                ),
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
