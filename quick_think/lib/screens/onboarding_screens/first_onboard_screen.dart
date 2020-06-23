import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
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
        color: Color(0xFF1C1046),
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
                color: Color(0XFF18C5D9),
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
      margin: EdgeInsets.only(top: mediaQuery.size.height * .1),
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
            'choose any number of question you want to anwser',
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
            color: Color(0xFF18C5D9),
            child: Text(
              'Next',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SecondOnBoardScreen())),
          ),
        ),
      ),
    );
  }
}
