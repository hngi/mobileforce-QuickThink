import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/config.dart';

class SettingsView extends StatefulWidget with WidgetsBindingObserver {
  @override
  _SettingsViewState createState() => _SettingsViewState();
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
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0)),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              child: ListTile(
                onTap: currentTheme.darkTheme,
                title: Text(
                  "Dark Theme",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.0)),
                ),
                leading: Icon(
                  FlutterIcons.wi_night_clear_wea,
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
                onTap: currentTheme.lightTheme,
                title: Text(
                  "Light Theme",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.0)),
                ),
                leading: Icon(
                  FlutterIcons.sun_fea,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
