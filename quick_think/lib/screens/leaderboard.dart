import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/model/leaderboard_model.dart';
import 'package:quickthink/theme/theme.dart';
import 'package:quickthink/utils/responsiveness.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  bool light = CustomTheme.light;
  final model = LeaderboardModel();

  List topUsers;

  @override
  void initState() {
    model.getLeaderboard("1002");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
/*    Timer.periodic(
      Duration(minutes: 5),
      refreshBoard
    );*/
    return Scaffold(
      backgroundColor: light ? Color(0xff1C1046) : Hexcolor('#000000'),
      body: SafeArea(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _appBar(context),
            ),
            Expanded(
              flex: 2,
              child: _leaders(light, context),
            ),
            Expanded(
              flex: 3,
              child: _resultContainer(light, context),
            ),
          ],
        ),

      ),
    );

  }

  void refreshBoard(Timer timer) {
    setState(() {
      model.getLeaderboard("1002");
    });
  }
}

Widget _appBar(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: _text(context)),
    ],
  );
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

Widget _leaders(light, context) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _roundContainer('2', 'Rick', light, context)),
          Expanded(child: _roundContainer1('Homer ', light, context)),
          Expanded(child: _roundContainer('3', 'Morty', light, context))
        ],
      ));
}

Widget _text(context) {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        'Leaderboard',
        style: GoogleFonts.poppins(
            fontSize: SizeConfig().textSize(context, 3.5),
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ));
}

Widget _roundContainer(String text1, String text2, bool light, context) {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
              backgroundColor: light ? Color(0xff574E76) : Hexcolor('#2B2B2B'),
              radius: SizeConfig().xMargin(context, 8),
              child: Text(text1,
                  style: GoogleFonts.poppins(
                      fontSize: SizeConfig().textSize(context, 3),
                      color: Colors.white))),
          SizedBox(height: 10),
          Text(text2,
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig().textSize(context, 3),
                  color: Colors.white))
        ],
      ));
}

Widget _roundContainer1(String text1, light, context) {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
              backgroundColor: light ? Color(0xff574E76) : Hexcolor('#2B2B2B'),
              radius: 50,
              child: SvgPicture.asset('images/trophy.svg')),
          Text(text1,
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig().textSize(context, 3),
                  color: Colors.white))
        ],
      ));
}


Widget _resultContainer(bool light, BuildContext context) {
  return Container(
      height: MediaQuery.of(context).size.height * .25,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
      decoration: BoxDecoration(
        color: light ? Colors.white : Hexcolor('#4C4C4C'),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _row('images/cup.svg', 'images/face1.png', 'images/coin2.svg',
                  'Homer simpson', '2000', light, context),
              _row1('2', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '1500', light, context),
              _row1('3', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '700', light, context),
              _row1('4', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '200', light, context),
              _row1('5', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '200', light, context),
              _row1('6', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '1500', light, context),
              _row1('7', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '700', light, context),
              _row1('8', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '200', light, context),
              _row1('9', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '1500', light, context),
              _row1('10', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '700', light, context),
              _row1('11', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '200', light, context),
              _row1('12', 'images/face2.png', 'images/coin2.svg',
                  'Rick thompson', '200', light, context),
            ],
          ),
        ),
      ));
}

Widget _row(String image1, String image2, String image3, String text1,
    String text2, bool light, context) {
  return Container(
    padding: EdgeInsets.only(top: 40),
    child: Row(
      children: <Widget>[
        SvgPicture.asset(image1),
        SizedBox(width: 10),
        Image.asset(image2, width: 20, height: 20),
        SizedBox(width: 10),
        Text(
          text1,
          style: GoogleFonts.poppins(
            fontSize: SizeConfig().textSize(context, 2),
            color: light ? Color(0xff1C1046) : Colors.white,
          ),
        ),
        Spacer(),
        SvgPicture.asset(image3, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text2,
            style: GoogleFonts.poppins(
              fontSize: SizeConfig().textSize(context, 2),
              color: light ? Color(0xff1C1046) : Colors.white,
            )),
      ],
    ),
  );
}

Widget _row1(String text, String image2, String image3, String text1,
    String text2, bool light, context) {
  return Container(
    padding: EdgeInsets.only(top: 40),
    child: Row(
      children: <Widget>[
        Text(text,
            style: GoogleFonts.poppins(
              fontSize: SizeConfig().textSize(context, 2),
            )),
        SizedBox(width: 20),
        Image.asset(image2, width: 20, height: 20),
        SizedBox(width: 13),
        Text(
          text1,
          style: GoogleFonts.poppins(
            fontSize: SizeConfig().textSize(context, 2),
          ),
        ),
        Spacer(),
        SvgPicture.asset(image3, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text2,
            style: GoogleFonts.poppins(
              fontSize: SizeConfig().textSize(context, 2),
            )),
      ],
    ),
  );
}

Widget Error(String error){
  return Center(
    child: Text(error, style: GoogleFonts.poppins(fontSize: 14))
  );
}
