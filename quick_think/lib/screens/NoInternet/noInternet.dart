import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/utils/responsiveness.dart';

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        SizedBox(
          height: 150.0,
        ),
        Container(
          height: 270.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/noInternet.png")),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "No Connection",
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: "Sofia",
            letterSpacing: 1.1,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Text(
            "Ooops No internet connection found. Check your connection or try again",
            style: GoogleFonts.poppins(
              fontSize: SizeConfig().textSize(context, 2),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ]),
    );
  }
}
