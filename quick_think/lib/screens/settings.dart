import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/utils/notifications_manager.dart';

import '../bottom_navigation_bar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  NotificationsManager notificationsManager = NotificationsManager();
  bool _checked;
  @override
  void initState() {
    super.initState();
    notificationsManager.initializeNotifications();
    /*notificationsManager.setOnNotificationClick();*/
    _checked = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1046),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1046),
        elevation: 0,
        title: InkWell(
          child: IconButton(
              icon: Icon(
                FlutterIcons.ios_arrow_back_ion,
                color: Colors.white,
              ),
              onPressed: (){}
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Settings",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 2.0
                  )
              ),
            ),
            SizedBox(height: 30,),
            Text(
              "App Theme",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2.0
                  )
              ),
            ),
            SizedBox(height: 20.0,),
            InkWell(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
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
                leading: Icon(FlutterIcons.moon_fea,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 50, 0),
              child: Divider(
                height: 5.0,
                color: Colors.white70,
              ),
            ),
            CheckboxListTile(
              title: Text(
                "Set Daily Reminders!",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2.0
                    )
                ),
              ),
                secondary: Icon(
                  FlutterIcons.ios_notifications_ion,
                  color: Colors.white,
                ),
                value: _checked,
                onChanged: (bool value){
                  setState(() {
                    _checked = value;
                  });
                },
            )
          ],
        ),
      ),
    );
  }

  onNotificationClick(String payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }
}


