import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/screens/onboarding_screens/second_onboard_screen.dart';

class OnBoardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Material(
      elevation: 130,
      child: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        padding: EdgeInsets.only(top: mediaQuery.size.height * 0.1),
        color: Hexcolor('#1C1046'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headerName(),
            _showPhoneIcon(mediaQuery),
            _showText(mediaQuery),
            _showButton(mediaQuery, context)
          ],
        ),
      ),
    );
  }

  Widget _headerName() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Quick',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            'Think',
            style: TextStyle(
                color: Hexcolor('#18C5D9'),
                fontSize: 18,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _showPhoneIcon(MediaQueryData mediaQuery) {
    return Container(
      height: mediaQuery.size.height * 0.33,
      margin: EdgeInsets.only(top:  mediaQuery.size.height * .1),
      padding: EdgeInsets.all(3.0),
      child: Center(
        child: Image.asset(
          'assets/images/phone_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _showText(MediaQueryData mediaQuery) {
    return Container(
      padding: EdgeInsets.all(3.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.size.width * 0.066),
          child: Text(
            'Choose any number of question you want to anwser',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery.size.width * 0.06,
                fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }

  Widget _showButton(MediaQueryData mediaQuery, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mediaQuery.size.height * 0.04),
      padding: const EdgeInsets.all(3.0),
      child: Center(
        child: SizedBox(
          height: 55,
          width: 150,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Hexcolor('#18C5D9'),
            child: Text(
              'Next',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            ),
            onPressed: () => /* Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SecondOnBoardScreen())) */
                Navigator.of(context).push(_createRoute()),
                
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SecondOnBoardScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOutExpo;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}