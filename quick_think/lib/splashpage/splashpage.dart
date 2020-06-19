import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      //Background color
      backgroundColor: Color(0xFF1C1046),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildVector(height, width),
          _buildAppName(),
        ],
      ),
    );
  }

//Vector Image
  Widget _buildVector(height, width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/splash_vector.png',
          ),
          //   fit: BoxFit.scaleDown
        ),
      ),
    );
  }

  /// AppName
  Widget _buildAppName() {
    return Center(
      child: Container(
        child: RichText(
          text: TextSpan(
            text: 'Quick',
            style: GoogleFonts.dmSans(
              fontSize: 32,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Think',
                style: GoogleFonts.dmSans(
                  fontSize: 32,
                  color: Color(0xFF18C5D9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
