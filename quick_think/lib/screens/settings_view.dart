import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/config.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:quickthink/widgets/noInternet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'login/view/login.dart';

class SettingsView extends StatefulHookWidget with WidgetsBindingObserver {
  static const routeName = 'settings_view';
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String token;

  //Check Internet Connectivity
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool _connection = false;

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('token') ?? null;
    setState(() {
      token = user;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('username');
  }

  @override
  void initState() {
    //Check Internet Connectivity
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult connectivityResult) {
        _connectionStatus = connectivityResult.toString();
        print(_connectionStatus);
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          if (!mounted) return;
          setState(() {
            startTimer();
            _connection = false;
          });
        } else {
          if (!mounted) return;
          setState(() {
            _connection = true;
          });
        }
      },
    );
    getUsername();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

//Navigate to Page When Connectivity is back
  startTimer() async {
    return new Timer(
      Duration(milliseconds: 500),
      () {
        Navigator.pushReplacementNamed(context, 'settings_view');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = useProvider(apiState);
    return
        // _connection
        //  ? NoInternet()
        //:
        Scaffold(
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
            SizedBox(height: SizeConfig().yMargin(context, 8)),
            token == null 
                ? Container()
                : Text(
                    "Account",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.0)),
                  ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 0, 50, 0),
            //   child: Divider(
            //     height: 5.0,
            //     color: Colors.white70,
            //   ),
            // ),
            token == null
                ? Container()
                : InkWell(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {
                        // state.logout().then((value) {
                        //   if (value != null) {
                        //     Get.to(LoginScreen());
                        //   }
                        // });
                        logout();
                        Get.off(LoginScreen());
                      },
                      title: Text(
                        "Log out",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.0),
                        ),
                      ),
                      leading: SvgPicture.asset('images/log-out.svg'),
                    ),
                  ),
            token == null
                ? Container()
                : InkWell(
                    child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    onTap: () {
                      state.deleteAccount().then((value) {
                        if (value != null) {
                          Future.delayed(Duration(seconds: 3))
                              .then((value) => Get.off(LoginScreen()));
                        }
                      });
                    },
                    title: Text(
                      "Delete account",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.0)),
                    ),
                    leading: SvgPicture.asset('images/trash-2.svg'),
                  )),
          ],
        ),
      ),
    );
  }
}
