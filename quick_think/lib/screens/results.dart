import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:flutter_svg/flutter_svg.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1046),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              child: ListTile(
                leading: SvgPicture.asset("images/coin.svg"),
                title: Text(
                  "80 points",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Colors.white,
                  ),
                ),
                trailing: SizedBox(
                  width: 35.0,
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
              child: ListTile(
                title: Text(
                  "Check leaderboard",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
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
              child: ListTile(
                title: Text(
                  "New quiz",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              // for inputing the social media icons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SvgPicture.asset(
                  "images/IG.svg",
                  width: 90.0,
                ),
                SvgPicture.asset(
                  "images/twitter.svg",
                  width: 60.0,
                ),
                SvgPicture.asset(
                  "images/facebook.svg",
                  width: 60.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
