import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPage extends StatelessWidget {
  static const routeName = 'error_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1C1046),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _firstContainer(),
                //  SizedBox(height: 20),
                _secondContainer(),
                _text(),
                _containerText('10 Questions'),
                _containerText('20 Questions'),
                _containerText('30 Questions'),
                _containerText('40 Questions'),
                _containerText('50 Questions'),
              ],
            ),
          ),
        ));
  }
}

Widget _firstContainer() {
  return Container(
    child: Image.asset('images/error.png'),
  );
}

Widget _secondContainer() {
  return Container(
    margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
    padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
    decoration: BoxDecoration(
        color: Color(0xff574E76), borderRadius: BorderRadius.circular(10)),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  'images/coin2.svg',
                ),
                SizedBox(width: 10),
                Text(
                  '1000',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Text('Points',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    )),
              ],
            )
          ],
        ),
        SizedBox(width: 100),
        SvgPicture.asset('images/line.svg'),
        SizedBox(width: 30),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  'images/medal.svg',
                ),
                SizedBox(width: 10),
                Text(
                  '30th',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Text('Ranking',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    )),
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget _text() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
    child: Text('Choose number of questions',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
        )),
  );
}

Widget _containerText(String text) {
  double width = 350;
  double height = 63;
  return Container(
    height: height,
    width: width,
    margin: EdgeInsets.fromLTRB(30, 10, 10, 10),
    padding: EdgeInsets.all(20),
    child: Text(text,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Color(0xff38208C)),
  );
}
