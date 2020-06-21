import 'package:flutter/material.dart';


import 'splashpage/splashpage.dart';
import 'data/FetchedQuestions.dart';
import 'screens/results deep_blue_theme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Result(),
    );
  }
}
