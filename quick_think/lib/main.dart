import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:quickthink/registration.dart';
import 'package:quickthink/screens/home.dart';
import 'package:quickthink/views/settings_view.dart';
import 'bottom_navigation_bar.dart';
import 'splashpage/splashpage.dart';


void main() {
=======
import 'splashpage/splashpage.dart';
import 'screens/onboarding_screens/first_onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int onBoardCount;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  onBoardCount = pref.getInt("first");
  await pref.setInt("first", 1);
>>>>>>> Added onboarding
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
<<<<<<< HEAD
      home: BottomNavBar(),
=======
      initialRoute: onBoardCount == 0 || onBoardCount == null
          ? 'showOnBoardScreen'
          : 'showSplashPage',
      routes: {
        'showOnBoardScreen': (context) => OnBoardScreen(),
        'showSplashPage': (context) => SplashPage(),
      },
>>>>>>> Added onboarding
    );
  }
}
