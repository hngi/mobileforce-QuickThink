

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/config.dart';
import 'package:quickthink/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SettingsView extends StatefulWidget with WidgetsBindingObserver {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

void logOut(context) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs?.clear();
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => Registration()),
    ModalRoute.withName('/showOnboardScreen'),);
}

// Future<http.Response> delete(String id) async {
//   final http.Response response = await http.delete(
//     'https://jsonplaceholder.typicode.com/albums/$id',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );
  


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
              onTap: () => logOut(context),
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
              onTap: (){}, //delete()
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
