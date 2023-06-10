import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final List<String> Suggestion = [
  "ISS (ZARYA)",
  "CENTAURI-2",
  "CENTAURI-1",
  "PROXIMA I",
  "PROXIMA II",
  "ROBUSTA 1B",
  "ITASAT 1",
  "NORSAT 2",
  "AISSAT 1",
  "WARP-01",
  "NORSAT 3",
  "AISSAT 2",
];

class TLEScreen extends StatefulWidget {
  @override
  _TLEScreenState createState() => _TLEScreenState();
}

class _TLEScreenState extends State<TLEScreen> {
  List<Map<String, dynamic>> satelliteData = [];
  TextEditingController _searchController = TextEditingController();

  void searchSatelliteData(String satelliteName) {
    final apiUrl = 'http://tle.ivanstanojevic.me/api/tle?search=$satelliteName';

    http.get(Uri.parse(apiUrl)).then((response) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final member = data['member'];
        if (!(member.isNotEmpty)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Failed to fetch satellite data'),
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
        } else {
          setState(() {
            satelliteData = List<Map<String, dynamic>>.from(member);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      labelText: 'Search by Satellite Name',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Search'),
                  onPressed: () {
                    final satelliteName = _searchController.text.trim();
                    if (satelliteName.isNotEmpty) {
                      searchSatelliteData(satelliteName);
                    }
                  },
                ),
              ],
            ),
          ),
          satelliteData.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: satelliteData.length,
                    itemBuilder: (context, index) {
                      final satellite = satelliteData[index];
                      return ListTile(
                        title: Text('ID: ${satellite['satelliteId']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${satellite['name']}'),
                            Text('TLE Line 1: ${satellite['line1']}'),
                            Text('TLE Line 2: ${satellite['line2']}'),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Text("Search Suggestions:",
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold)),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 10,
              ),
              itemCount: Suggestion.length,
              itemBuilder: (context, index) {
                return Center(
                  child: ElevatedButton(
                      child: Text(
                        Suggestion[index],
                      ),
                      onPressed: () {
                        final satelliteName = Suggestion[index];
                        if (satelliteName.isNotEmpty) {
                          searchSatelliteData(satelliteName);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onPrimary: Colors.purple,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
