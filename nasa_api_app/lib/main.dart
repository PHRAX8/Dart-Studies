import 'package:flutter/material.dart';
import 'package:nasa_api_app/tle_screen.dart';
import 'package:nasa_api_app/mars_rover_screen.dart';
import 'package:nasa_api_app/NASALibrary.dart';

void main() => runApp(NasaApiApp());

class NasaApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA API App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TleScreen(),
    MarsRoverScreen(),
    NASALibrary(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NASA API App'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.satellite),
            label: 'TLE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera),
            label: 'Mars Rover Album',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'NASA Image Library',
          ),
        ],
      ),
    );
  }
}
