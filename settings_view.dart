// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/config.dart';
import 'package:quickthink/screens/onboarding_screens/first_onboard_screen.dart';
import 'package:http/http.dart' as http;

class SettingsView extends StatefulWidget with WidgetsBindingObserver {

  @override
  _SettingsViewState createState() => _SettingsViewState();
}



const bearerId = "Bearer 7b86a5d6955dd524e1250fd4d4a640e0f22a4ee8";
Future logOut(String bearerId, BuildContext context) async{
  var url = 'http://brainteaser.pythonanywhere.com/user/logout';
  var response = await http.post(url, headers: {HttpHeaders.authorizationHeader: bearerId});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode == 200){
    Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context) => OnBoardScreen()),
    ModalRoute.withName(''));
  }
  else{
    showError(context);
  }
}

void showError(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(""),
        content: Text("Error Logging Out!",
        style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Color(0xff1C1046),
          fontWeight: FontWeight.w600,
          fontSize: 18),)
          ),
        actions: <Widget>[
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 41, vertical: 17),
            shape: RoundedRectangleBorder(),
            color: Color(0xff18C5D9),
            onPressed: () {Navigator.of(context).pop();},
            child: Text("Ok",
            style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18),),),
          )
        ]
      ); 
    },  );
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(""),
        content: Text("Coming Soon!",
        style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Color(0xff1C1046),
          fontWeight: FontWeight.w600,
          fontSize: 18),)
          ),
        actions: <Widget>[
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 41, vertical: 17),
            shape: RoundedRectangleBorder(),
            color: Color(0xff18C5D9),
            onPressed: () {Navigator.of(context).pop();},
            child: Text("Ok!",
            style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18),),),
          )
        ]
      ); 
    },  );
}
  


class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
          child: Text(
            "Settings",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "App Theme",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0)),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                onTap: currentTheme.darkTheme,
                title: Text(
                  "Dark Theme",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          // fontWeight: FontWeight.w500,
                          letterSpacing: 2.0)),
                ),
                leading: Icon(
                  FlutterIcons.moon_fea,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 50, 0),
              child: Divider(
                height: 5.0,
                color: Colors.white70,
              ),
            ),
            InkWell(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                onTap: currentTheme.lightTheme,
                title: Text(
                  "Light Theme",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          // fontWeight: FontWeight.w500,
                          letterSpacing: 2.0)),
                ),
                leading: Icon(
                  FlutterIcons.sun_fea,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Text("Account",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),)
            ),
            SizedBox(height: 16,),
            InkWell(
              onTap: () => logOut,
              child: ListTile(
                title: Text("Logout",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  )
                  ),),
                  leading: Icon(FlutterIcons.log_out_fea, color: Colors.white),
                )
            ),
            InkWell(
              onTap: () => _showDialog(context), 
              child: ListTile(
                title: Text("Delete account",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.white, 
                    letterSpacing: 2.0
                  )
                ),),
                leading: Icon(FlutterIcons.delete_ant, color: Colors.white)
              )
            ) 
          ],
        ),
      ),
    );
  }
}




