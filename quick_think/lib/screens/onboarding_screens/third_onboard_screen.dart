import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/bottom_navigation_bar.dart';
import 'package:quickthink/screens/login/responsiveness/res.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:quickthink/screens/join_game.dart';

class ThirdOnBoardScreen extends StatefulWidget {
  @override
  _ThirdOnBoardScreenState createState() => _ThirdOnBoardScreenState();
}

class _ThirdOnBoardScreenState extends State<ThirdOnBoardScreen> {
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
             Align(
              alignment: Alignment.center,
              child: Container(
                width: McGyver.rsDoubleW(context, 30),
                height: McGyver.rsDoubleH(context, 20),
                decoration: BoxDecoration(
                    // color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage('assets/app_name_vector.png'))),
              ),
            ),
             SizedBox(
              height: SizeConfig().yMargin(context, 6.0),
            ),
            Expanded(
              flex: 2,
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
            SizedBox(
              height: SizeConfig().yMargin(context, 6.0),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _vector(height, width) {
    return Container(
      height: SizeConfig().yMargin(context, 70),
      width: SizeConfig().xMargin(context, 200),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          'assets/images/social_media_icon.png',
        ),
        fit: BoxFit.none,
      )),
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
          'Share your score with friends and family',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig().textSize(context, 2.5),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Hexcolor('#18C5D9'),
                child: Text(
                  'Next',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig().textSize(context, 2),
                      color: Colors.white),
                ),
                onPressed: () => Navigator.of(context)
                    .pushAndRemoveUntil(_createRoute(), (route) => false))
            /* Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SecondOnBoardScreen())) */
            //  Navigator.of(context).pushandReplace(_createRoute()),

            ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOutQuint;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
