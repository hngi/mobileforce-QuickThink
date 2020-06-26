import 'package:flutter/material.dart';
import 'screens/splashpage.dart';
import 'screens/onboarding_screens/first_onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'registration.dart';
import 'theme/theme.dart';

int onBoardCount;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  onBoardCount = pref.getInt("first");
  await pref.setInt("first", 1);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      print("sometin");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF1C1046),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: themeDark,
      themeMode: currentTheme.currentTheme(),
      initialRoute: onBoardCount == 0 || onBoardCount == null
          ? 'showOnBoardScreen'
          : 'showSplashPage',
      routes: {
        'showOnBoardScreen': (context) => OnBoardScreen(),
        'showSplashPage': (context) => SplashPage(),
        Registration.id: (context) => Registration(),
      },
    );
  }
}
