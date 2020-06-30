import 'package:covidtracker/services/get_data.dart';
import 'package:covidtracker/views/home_page.dart';
import 'package:covidtracker/views/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppDetails>(
      create: (context) => AppDetails(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo[900],
          accentColor: Colors.orange
        ),
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}

