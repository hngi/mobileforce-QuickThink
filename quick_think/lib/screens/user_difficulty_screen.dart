import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/screens/quiz_screen.dart';

class UserDifficulty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: Hexcolor('#1C1046'),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 0.0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: Material(
                  //borderRadius: ,
                  color: Hexcolor('#ffffff'),
                  child: Container(
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height * .5,
                    padding:
                        EdgeInsets.only(top: mediaQuery.size.height * 0.05),
                    child: ListView(
                      children: <Widget>[
                        _showFirstRow(mediaQuery),
                        _showSecondRow(mediaQuery),
                        _showButton(mediaQuery, context)
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

Widget _showFirstRow(MediaQueryData mediaQuery) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Select Difficulty',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.help,
        )
      ],
    ),
  );
}

Widget _showSecondRow(MediaQueryData mediaQuery) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _firstClipRect(mediaQuery),
        _secondClipRect(mediaQuery),
        _thirdClipRect(mediaQuery)
      ],
    ),
  );
}

Widget _firstClipRect(MediaQueryData mediaQuery) {
  print('${mediaQuery.size.width}, ${mediaQuery.size.height}');
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Container(
      width: mediaQuery.size.width * .3,
      height: mediaQuery.size.height * .1,
      color: Hexcolor('#86EC88'),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(
                child: Text(
              'Easy',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(3.0),
            child: Center(
                child: Text(
              '05:00 min',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          )
        ],
      ),
    ),
  );
}

Widget _secondClipRect(MediaQueryData mediaQuery) {
  print('${mediaQuery.size.width}, ${mediaQuery.size.height}');
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Container(
      width: mediaQuery.size.width * .3,
      height: mediaQuery.size.height * .1,
      color: Hexcolor('#FBBD00'),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(
                child: Text(
              'Average',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(3.0),
            child: Center(
                child: Text(
              '10:00 min',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          )
        ],
      ),
    ),
  );
}

Widget _thirdClipRect(MediaQueryData mediaQuery) {
  print('${mediaQuery.size.width}, ${mediaQuery.size.height}');
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Container(
      width: mediaQuery.size.width * .3,
      height: mediaQuery.size.height * .1,
      color: Hexcolor('#FF4D55'),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(
                child: Text(
              'Hard',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(3.0),
            child: Center(
                child: Text(
              '20:00 min',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          )
        ],
      ),
    ),
  );
}

Widget _showButton(MediaQueryData mediaQuery, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: mediaQuery.size.height * .02),
    height: mediaQuery.size.height * .1,
    width: mediaQuery.size.width * .25,
    padding: const EdgeInsets.all(10.0),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: SizedBox(
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Hexcolor('#18C5D9'),
            child: Text(
              'Start game',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            onPressed: ()  => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => QuizScreen())),
          ),
        ),
      ),
  );
}
