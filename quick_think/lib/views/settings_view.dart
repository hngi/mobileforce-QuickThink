import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1046),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1046),
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
                letterSpacing: 2.0
              )
            ),
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
                      letterSpacing: 2.0
                  )
              ),
            ),
            SizedBox(height: 20.0,),
            InkWell(
              child: ListTile(
                  onTap: (){},
                title: Text(
                  "Dark Theme",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.0
                      )
                  ),
                ),
                leading: Icon(FlutterIcons.wi_night_clear_wea,
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
                onTap: (){},
                title: Text(
                  "Light Theme",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.0
                      )
                  ),
                ),
                leading: Icon(FlutterIcons.sun_fea,
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
