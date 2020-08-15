import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/screens/create_category.dart';
import 'package:quickthink/screens/create_game.dart';
import 'package:quickthink/screens/join_game.dart';
import 'package:quickthink/screens/login/view/login.dart';
import 'package:quickthink/theme/theme.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:quickthink/views/question_view.dart';
import 'package:quickthink/screens/quiz_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'category/screens/create_category.dart';
import 'help.dart';

class NewSettingsView extends StatefulWidget {

  NewSettingsView({Key key, this.uri}) : super(key: key);
  final String uri;

  @override
  _NewSettingsViewState createState() => _NewSettingsViewState();
}

class _NewSettingsViewState extends State<NewSettingsView> {
  bool light = CustomTheme.light;
  String na = 'There';
  String username;
  static const snackBarDuration = Duration(seconds: 3);
  final snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text('Press back again to exit'),
    duration: snackBarDuration,
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime backButtonPressTime;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }
    SystemNavigator.pop();
    return false;
  }

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('username') ?? null;
    setState(() {
      username = user;
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: light ? Color(0xff1c1046) : Hexcolor('#000000'),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF18C5D9).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Color(0xff18C5D9),
          onPressed: () {
            helpAlert(context);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => InfoHelp()));
          },
          child: Text(
            "?",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(14.0, 0, 14.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Hello, ",
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        SizeConfig().textSize(context, 3.2),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: username ?? na,
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        SizeConfig().textSize(context, 3.2),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n'),
                            TextSpan(
                                text: "Glad you're back",
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        SizeConfig().textSize(context, 2.2),
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold)),
                          ]),
                        ),
                        Container(
                          child: CircleAvatar(
                              backgroundColor: Color(0xff38208c),
                              radius: 28.5,
                              child: widget.uri != null
                                  ? SvgPicture.asset(
                                      "assets/images/${widget.uri}.svg")
                                  : SvgPicture.asset("assets/images/owl.svg")
                              //Image.asset("assets/images/owl 1.png"),
                              ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig().yMargin(context, 2)),
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Settings',
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig().textSize(context, 3),
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: SizeConfig().yMargin(context, 2),
                        ),
                        QuestionSelectionCard(
                          text: 'Change Avatar',
                          onPressed: () async {
                            Navigator.pushNamed(context, JoinGame.routeName);
                          },
                          light: light,
                        ),
                        SizedBox(
                          height: SizeConfig().yMargin(context, 2),
                        ),
                        QuestionSelectionCard(
                          text: 'Delete Account',
                          onPressed: () async {
                            Navigator.pushNamed(context, CreateGame.routeName);
                          },
                          light: light,
                        ),
                        SizedBox(
                          height: SizeConfig().yMargin(context, 2),
                        ),
                        QuestionSelectionCard(
                          text: 'Create questions',
                          onPressed: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            final key = "token";
                            final valueStored = pref.getString(key) ?? null;
                            print(valueStored);
                            if (valueStored == null) {
                              Get.to(LoginScreen());
                            } else {
                              //Navigate to create questions page
                              Navigator.pushNamed(
                                  context, CreateCategory.routeName);
                            }
                          },
                          light: light,
                        ),
                      SizedBox(
                          height: SizeConfig().yMargin(context, 2),
                        ),
                        QuestionSelectionCard(
                          text: 'About Us',
                          onPressed: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            final key = "token";
                            final valueStored = pref.getString(key) ?? null;
                            print(valueStored);
                            if (valueStored == null) {
                              Get.to(LoginScreen());
                            } else {
                              //Navigate to create questions page
                              Navigator.pushNamed(
                                  context, CreateCategory.routeName);
                            }
                          },
                          light: light,
                        ),
                        SizedBox(
                          height: SizeConfig().yMargin(context, 2),
                        ),
                        QuestionSelectionCard(
                          text: 'Log out',
                          onPressed: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            final key = "token";
                            final valueStored = pref.getString(key) ?? null;
                            print(valueStored);
                            if (valueStored == null) {
                              Get.to(LoginScreen());
                            } else {
                              //Navigate to create questions page
                              Navigator.pushNamed(
                                  context, CreateCategory.routeName);
                            }
                          },
                          tabColor: Color(0xffff4d55),
                        ),
                      
                      
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionSelectionCard extends StatelessWidget {
  final String text;
  final onPressed;
  final light;
  final Color tabColor;

  QuestionSelectionCard({@required this.text, this.onPressed, this.light, this.tabColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: SizeConfig().xMargin(context, 4),
      height: SizeConfig().yMargin(context, 8),
      child: InkWell(
        onTap: () {},
        child: RaisedButton(
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: tabColor ?? Color(0xff38208c) /* : Hexcolor('#4C4C4C') */,
          // padding: EdgeInsets.fromLTRB(32, 20, 0, 17),
          child: Align(
              alignment: Alignment.center,
              child: Text(text,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig().textSize(context, 2.3),
                      color: Colors.white))),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
