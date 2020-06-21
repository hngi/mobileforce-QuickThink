import 'package:flutter/material.dart';
import 'package:quickthink/screens/first_onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isOnBoard;
void main() async{
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // isOnBoard = pref.getInt("is_onboard");
  // await pref.setInt("is_onboard", 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      initialRoute: isOnBoard == true || isOnBoard == null ? 'showOnBoardScreen' : 'showRegistrationScreen',
      routes: {
        'showOnBoardScreen': (context) => OnBoardScreen(),
        //'showRegistrationScreen': (context) => showRegistrationScreen(),
      },
    );
  }
}