import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';


class QuizScreen extends StatefulWidget {
  

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
Timer _timer;
int start = 30;

void startTimer() {
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) => setState(
      () {
        if (start < 1) {
          timer.cancel();
        } else {
          start = start - 1;
          print('the time is $start');
        }
      },
    ),
  );
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        color: Hexcolor('#1C1046'),
        child: Column(
          children: <Widget>[
            _backArrow(mediaQuery, context),
            _secondRow(mediaQuery, context, start),
            _thirdRow(mediaQuery),
            _fourthRow(mediaQuery),
            _questionsRow(mediaQuery, context)
          ],
        ),
      ),
    );
  }
}

Widget _backArrow(MediaQueryData mediaQuery, BuildContext context) {
  return Container(
    //height: mediaQuery.size.height * 0.33,
    margin: EdgeInsets.only(top: mediaQuery.size.height * .02),
    padding: EdgeInsets.all(10.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        'assets/images/back_arrow.png',
        fit: BoxFit.contain,
      ),
    ),
  );
}

Widget _secondRow(MediaQueryData mediaQuery, BuildContext context, value) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '10 questions',
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        _levelBox(mediaQuery),
        _timerBox(mediaQuery, context, value),
      ],
    ),
  );
}

Widget _levelBox(MediaQueryData mediaQuery) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Container(
        width: mediaQuery.size.width * .25,
        height: mediaQuery.size.height * .05,
        color: Hexcolor('#574E76'),
        child: Center(
          child: Text(
            'Easy',
            style: TextStyle(
              color: Hexcolor('#86EC88'),
              fontSize: 15,
            ),
          ),
        )),
  );
}

Widget _timerBox(MediaQueryData mediaQuery, BuildContext context, int value) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Container(
        width: mediaQuery.size.width * .25,
        height: mediaQuery.size.height * .05,
        color: Hexcolor('#574E76'),
        child: Center(
          child: Text(
            '00:$value',
            style: TextStyle(
                color: Hexcolor('#ffffff'),
                fontWeight: FontWeight.bold,
                fontSize: 19),
          ),
        )),
  );
}

Widget _thirdRow(MediaQueryData mediaQuery) {
  return Container(
    margin: EdgeInsets.only(top: mediaQuery.size.height * .05),
    child: Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          'Question 1 of 10',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ),
  );
}

Widget _fourthRow(MediaQueryData mediaQuery) {
  int slidderValue = 10;
  return Container(
    margin: EdgeInsets.only(top: mediaQuery.size.height * .01),
    child: Align(
      alignment: Alignment.topLeft,
      child: Slider(
          value: slidderValue.toDouble(),
          onChanged: (double value) => {

          },
          divisions: 4,
          min: 0.0,
          max: 40,
          activeColor: Hexcolor('#18C5D9'),
          inactiveColor: Colors.white,
        )
    ),
  );
}

Widget _sliderRow(MediaQueryData mediaQuery) {
  return Container();
}

Widget _questionsRow(MediaQueryData mediaQuery, BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(0.0),
    child: Container(
        height: mediaQuery.size.height * 0.6,
        width: mediaQuery.size.width * .9,
        margin: EdgeInsets.only(top: mediaQuery.size.height * .025),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            _headerText(mediaQuery),
            _firstOption(mediaQuery),
            _secondOption(mediaQuery),
            _thirdOption(mediaQuery),
            _fourthOption(mediaQuery),
            _btnNext(mediaQuery, context)
          ],
        )),
  );
}

Widget _headerText(MediaQueryData mediaQuery) {
  return Container(
    margin: EdgeInsets.only(top: mediaQuery.size.height * .05),
    child: Align(
      alignment: Alignment.topCenter,
      child: Text(
        'When was leonardo da vinci born?',
        style: TextStyle(
            color: Hexcolor('#38208C'),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _firstOption(MediaQueryData mediaQuery) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          width: mediaQuery.size.width * .9,
          height: mediaQuery.size.height * .07,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Hexcolor('#C4C4C4')),
          ),
          margin: EdgeInsets.only(top: mediaQuery.size.height * .12),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '1993',
              style: TextStyle(
                color: Hexcolor('#38208C'),
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _secondOption(MediaQueryData mediaQuery) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          width: mediaQuery.size.width * .9,
          height: mediaQuery.size.height * .07,
          color: Hexcolor('#86EC88'),
          margin: EdgeInsets.only(top: mediaQuery.size.height * .22),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/green_mark.png',
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '1956',
                  style: TextStyle(
                    color: Hexcolor('#38208C'),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _thirdOption(MediaQueryData mediaQuery) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          width: mediaQuery.size.width * .9,
          height: mediaQuery.size.height * .07,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Hexcolor('#C4C4C4')),
          ),
          margin: EdgeInsets.only(top: mediaQuery.size.height * .32),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '1953',
              style: TextStyle(
                color: Hexcolor('#38208C'),
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _fourthOption(MediaQueryData mediaQuery) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          width: mediaQuery.size.width * .9,
          height: mediaQuery.size.height * .07,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Hexcolor('#C4C4C4')),
          ),
          margin: EdgeInsets.only(top: mediaQuery.size.height * .42),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '1973',
              style: TextStyle(
                color: Hexcolor('#38208C'),
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _btnNext(MediaQueryData mediaQuery, BuildContext context) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      width: mediaQuery.size.width * .25,
      height: mediaQuery.size.height * .07,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Hexcolor('#18C5D9'),
        child: Text(
          'Next',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        onPressed: () => {},
      ),
    ),
  );
}
