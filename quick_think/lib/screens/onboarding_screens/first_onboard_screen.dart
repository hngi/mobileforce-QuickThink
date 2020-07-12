import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/screens/onboarding_screens/second_onboard_screen.dart';
import 'package:quickthink/utils/responsiveness.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _logoText(),
            ),
            Expanded(
              flex: 3,
              child: _vector(height, width),
            ),
            Expanded(
              flex: 1,
              child: _showText(),
            ),
            Expanded(
              flex: 1,
              child: _showButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoText() {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: 'Quick',
            style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig().textSize(context, 3),
                color: Colors.white)),
        TextSpan(
            text: 'Think',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig().textSize(context, 3),
              color: Color.fromRGBO(24, 197, 217, 1),
            ))
      ]),
    );
  }

  Widget _vector(height, width) {
    return Container(
      height: SizeConfig().yMargin(context, 70),
      width: SizeConfig().xMargin(context, 100),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          'assets/images/phone_icon.png',
        ),
        fit: BoxFit.fitHeight,
      )),
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
            style: TextStyle(
                fontSize: SizeConfig().textSize(context, 3),
                color: Colors.white),
          ),
          Text(
            'Think',
            style: TextStyle(
                color: Hexcolor('#18C5D9'),
                fontSize: SizeConfig().textSize(context, 3),
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _showPhoneIcon(MediaQueryData mediaQuery) {
    return Container(
      height: SizeConfig().yMargin(context, 50),

      // margin: EdgeInsets.only(top: mediaQuery.size.height * .1),
      //   padding: EdgeInsets.all(3.0),
      child: Center(
        child: Image.asset(
          'assets/images/phone_icon.png',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _showText() {
    return Container(
      padding: EdgeInsets.only(top: SizeConfig().yMargin(context, 4)),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig().xMargin(context, 9),
          right: SizeConfig().xMargin(context, 9),
        ),
        child: Text(
          'Choose any number of question you want to answer',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig().textSize(context, 2.7),
              fontFamily: 'Poppins'),
        ),
      ),
      //     ),
    );
  }

  Widget _showButton(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: mediaQuery.size.height * 0.04),
      // padding: const EdgeInsets.only(top: 18.0),
      child: Center(
        child: SizedBox(
          height: SizeConfig().yMargin(context, 6.0),
          width: SizeConfig().xMargin(context, 30),
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Hexcolor('#18C5D9'),
            child: Text(
              'Next',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig().textSize(context, 2),
                  color: Colors.white),
            ),
            onPressed: () =>
                /* Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SecondOnBoardScreen())) */
                Navigator.of(context).push(_createRoute()),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SecondOnBoardScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutExpo;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}
