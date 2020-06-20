import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickthink/model/question_model.dart';
import 'package:quickthink/registration.dart';
import 'package:quickthink/screens/home.dart';
import 'package:quickthink/views/settings_view.dart';
import 'bottom_navigation_bar.dart';

import 'splashpage/splashpage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(QuestionModelAdapter());
  await Hive.openBox<QuestionModel>('offlineQuestions');
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
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavBar(),
    );
  }
}
