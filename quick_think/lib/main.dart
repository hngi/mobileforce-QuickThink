import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickthink/screens/registration.dart';
import 'package:quickthink/screens/home.dart';
import 'package:quickthink/views/settings_view.dart';
import 'bottom_navigation_bar.dart';
import 'splashpage/splashpage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: devicepreview.of(context).locale,
      // builder: devicepreview.appbuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Registration(),
    );
  }
}
