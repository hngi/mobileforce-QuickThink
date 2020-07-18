import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/config.dart';
import 'package:quickthink/registration.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'login/view/login.dart';

class SettingsView extends StatefulHookWidget with WidgetsBindingObserver {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String token;
  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('token') ?? null;
    setState(() {
      token = user;
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = useProvider(apiState);
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
                contentPadding: EdgeInsets.all(0),
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
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.0)),
                ),
                leading: Icon(
                  FlutterIcons.sun_fea,
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
            token == null
                ? Container()
                : InkWell(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {
                        state.logout().then((value) {
                          if (value != null) {
                            Get.to(LoginScreen());
                          }
                        });
                      },
                      title: Text(
                        "Log out",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2.0)),
                      ),
                      leading: Icon(
                        FlutterIcons.account_circle_mco,
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
