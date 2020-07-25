import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150.0,
              ),
              Container(
                  height: 270.0,
                  child: SvgPicture.asset('assets/images/noInternet.svg')
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage("assets/images/noInternet2.png"),
                  //   ),
                  // ),
                  ),
              // SizedBox(
              //   height: SizeConfig().yMargin(context, 10),
              // ),
              Text(
                "Oops! Connection Lost",
                style: GoogleFonts.dmSans(
                  fontSize: SizeConfig().textSize(context, 3),
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(
                height: SizeConfig().yMargin(context, 3),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Text(
                  "Please check your internet connection",
                  style: GoogleFonts.dmSans(
                    color: Color(0xFFFFFFFF),
                    fontSize: SizeConfig().textSize(context, 2),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
