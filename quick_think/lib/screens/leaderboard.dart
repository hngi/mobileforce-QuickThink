import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C1046),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _arrow(),
                _text(),
              ],
            )),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _roundContainer('2', 'Rick'),
                          _roundContainer1('Homer Simpson'),
                          _roundContainer('3', 'Morty')
                        ],
                      )),
                  _resultContainer()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _arrow() {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Icon(
        Icons.keyboard_arrow_left,
        color: Colors.white,
        size: 30,
      ));
}

Widget _text() {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        'Leaderboard',
        style: GoogleFonts.poppins(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ));
}

Widget _roundContainer(String text1, String text2) {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Color(0xff574E76),
              radius: 30,
              child: Text(text1,
                  style:
                      GoogleFonts.poppins(fontSize: 16, color: Colors.white))),
          SizedBox(height: 10),
          Text(text2,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white))
        ],
      ));
}

Widget _roundContainer1(String text1) {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Color(0xff574E76),
              radius: 50,
              child: SvgPicture.asset('images/trophy.svg')),
          Text(text1,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white))
        ],
      ));
}

Widget _resultContainer() {
  return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          _row('images/cup.svg', 'images/face1.png', 'images/coin2.svg',
              'Homer simpson', '2000'),
          _row1('2', 'images/face2.png', 'images/coin2.svg', 'Rick thompson',
              '1500'),
          _row1('3', 'images/face2.png', 'images/coin2.svg', 'Rick thompson',
              '700'),
          _row1('4', 'images/face2.png', 'images/coin2.svg', 'Rick thompson',
              '200')
        ],
      ));
}

Widget _row(
    String image1, String image2, String image3, String text1, String text2) {
  return Container(
    padding: EdgeInsets.only(top: 40),
    child: Row(
      children: <Widget>[
        SvgPicture.asset(image1),
        SizedBox(width: 10),
        Image.asset(image2, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text1, style: GoogleFonts.poppins(fontSize: 14)),
        Spacer(),
        SvgPicture.asset(image3, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text2, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    ),
  );
}

Widget _row1(
    String text, String image2, String image3, String text1, String text2) {
  return Container(
    padding: EdgeInsets.only(top: 40),
    child: Row(
      children: <Widget>[
        Text(text, style: GoogleFonts.poppins(fontSize: 14)),
        SizedBox(width: 20),
        Image.asset(image2, width: 20, height: 20),
        SizedBox(width: 13),
        Text(text1, style: GoogleFonts.poppins(fontSize: 14)),
        Spacer(),
        SvgPicture.asset(image3, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text2, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    ),
  );
}
