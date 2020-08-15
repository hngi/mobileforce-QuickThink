import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/config.dart';
import 'package:quickthink/main.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';
import 'package:quickthink/utils/notifications_manager.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:quickthink/widgets/noInternet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../bottom_navigation_bar.dart';
import 'login/view/login.dart';

class SettingsView extends StatefulHookWidget with WidgetsBindingObserver {
  static const routeName = 'settings_view';
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  NotificationsManager notificationsManager = NotificationsManager();
  static List<String> hoursList = [
    '1:00',
    '2:00',
    '3:00',
    '4:00',
    '5:00',
    '6:00',
    '7:00',
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
    '24:00'
  ];
  String dropDownValue = hoursList[10];
  String token;
  bool reminderValue;
  SharedPreferences sharedPreferences;
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
    getReminderValue('reminder');
    getTimeValue('time');
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
    notificationsManager.initializeNotifications();
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
        automaticallyImplyLeading: false,
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
/*              Text(
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
                  //onTap: currentTheme.darkTheme,
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
                  //onTap: currentTheme.lightTheme,
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
              SizedBox(height: 10.0),*/
            reminderValue == null
                ? SpinKitThreeBounce(
                    color: Colors.white,
                    size: 12.0,
                  )
                : SwitchListTile(
                    contentPadding: EdgeInsets.only(right: 30),
                    title: Text(
                      "Set Daily Reminders!",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.0)),
                    ),
                    secondary: Icon(
                      FlutterIcons.ios_notifications_ion,
                      color: Colors.white,
                    ),
                    activeColor: Color(0xff18C5D9),
                    value: reminderValue,
                    onChanged: (bool value) {
                      setState(() {
                        reminderValue = value;
                        saveReminderValue('reminder', value);
                        if (value == false) {
                          notificationsManager.cancelNotificationWith(999);
                        } else {
                          notificationsManager.scheduleDailyNotifications(
                              int.parse(dropDownValue.split(':')[0]));
                        }
                      });
                    },
                  ),
            SizedBox(height: 10.0),
            reminderValue == false ? Container() : getDropDown(),
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

  Widget getDropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Set Reminder Time: ',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0)),
        ),
        SizedBox(width: 10.0),
        DropdownButton<String>(
          value: dropDownValue,
          icon: Icon(
            FlutterIcons.clock_outline_mco,
            color: Colors.white,
          ),
          iconSize: 14,
          elevation: 10,
          itemHeight: 50.0,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0)),
          underline: Container(
            height: 2,
            width: 10,
            color: Color(0xff18C5D9),
          ),
          dropdownColor: Hexcolor('#38208C'),
          onChanged: (String value) {
            setState(() {
              dropDownValue = value;
              saveTimeValue('time', value);
              notificationsManager.cancelNotificationWith(999);
              notificationsManager.scheduleDailyNotifications(
                  int.parse(dropDownValue.split(':')[0]));
            });
          },
          items: hoursList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }

  Future getReminderValue(String s) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final valueStored = sharedPreferences.getBool(s) ?? false;
    reminderValue = valueStored;
  }

  Future saveReminderValue(String s, bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(s, value);
  }

  Future getTimeValue(String s) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final valueStored = sharedPreferences.getString(s) ?? hoursList[10];
    dropDownValue = valueStored;
  }

  Future saveTimeValue(String s, String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(s, value);
  }
}
