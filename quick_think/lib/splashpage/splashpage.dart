import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Setting background color
      backgroundColor: Color(0xFF524971),
      body: Center(
        child: Image.asset('assets/AppName.png'),
      ),
    );
  }
}
