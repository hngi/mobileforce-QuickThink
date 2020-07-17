import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/create_category.dart';
import 'package:quickthink/screens/create_game.dart';
<<<<<<< HEAD
import 'package:quickthink/screens/dashboard.dart';
=======
import 'package:quickthink/screens/create_question.dart';
import 'package:quickthink/screens/created_categories.dart';
>>>>>>> 8250e253a4f7c78b98d1230d26da9f00ac21be95
import 'package:quickthink/screens/help.dart';
import 'package:quickthink/screens/join_game.dart';
import 'screens/login/view/login.dart';
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

  runApp(ProviderScope(child: MyApp()));
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
      print("something");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickThink',
      theme: ThemeData(
        primaryColor: Color(0xFF1C1046),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: themeLight.colorScheme,
      ),
      // darkTheme: themeDark,
      // themeMode: currentTheme.currentTheme(),
      initialRoute: onBoardCount == 0 || onBoardCount == null
          ? 'showOnBoardScreen'
          : 'showSplashPage',
      routes: {
        'showOnBoardScreen': (context) => DashBoard(username: 'Dumebi',),
        'showSplashPage': (context) => DashBoard(username: 'Dumebi',),
        Registration.id: (context) => Registration(),
        JoinGame.routeName: (context) => JoinGame(),
        CreateQuestion.routeName: (context) => CreateQuestion(),
        CreatedCategories.routeName: (context) => CreatedCategories()
      },
    );
  }
}
