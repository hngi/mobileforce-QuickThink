import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1046),
      body: SafeArea(
        
        child: Column(
          children: <Widget>[
            SizedBox(
          height: 300.0,
        ),
            Center(
              child: Text(
                "Congrats Tiana!!",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32.0,
                ),
              ),
            ),
            Center(
              child: Text(
                "You Scored:",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 25.0,
              ),
              color: Color(0xFF1C1046),
              shadowColor: Colors.black,
              elevation: 30.0,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 130.0,
                    ),
                    Text(
                      "80 points",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 18.0,
              ),
              color: Colors.white,
              elevation: 30.0,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 140.0,
                    ),
                    Text(
                      "Check leaderboard",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 18.0,
              ),
              color: Color(0xFF18C5D9),
              shadowColor: Colors.black,
              elevation: 30.0,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 180.0,
                    ),
                    Text(
                      "New quiz",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(// for inputing the social media icons
              children: <Widget>[
                Icon(
                  MyFlutterApp.twitter,
                  size: 200,
                ),
        
              ],
            ),
          ],
        ),
      ),
    );
  }
}
