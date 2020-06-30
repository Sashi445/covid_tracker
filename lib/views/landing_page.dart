import 'package:covidtracker/views/home_page.dart';
import 'package:covidtracker/views/world_wide_stats.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> _screens = [
    HomePage(),
    WorldWideStats()
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.pink
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            title: Text('Global'),
            backgroundColor: Colors.pink
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: false,
        onTap: (int selected){
          setState(() {
            _selectedIndex = selected;
          });
        },
      ),
    );
  }
}
