import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/board_screen.dart';
import 'package:quickthink/screens/category/screens/viewQuestions.dart';
import 'package:quickthink/screens/create_game.dart';
import 'package:quickthink/screens/help.dart';
import 'package:quickthink/screens/join_game.dart';
import 'package:quickthink/screens/settings_view.dart';
import 'screens/category/screens/create_category.dart';
import 'screens/category/screens/create_question.dart';
import 'bottom_navigation_bar.dart';
import 'screens/category/screens/created_categories.dart';

import 'package:quickthink/screens/help.dart';
import 'package:quickthink/screens/join_game.dart';
import 'package:quickthink/screens/new_dashboard.dart';
import 'package:quickthink/screens/registration_screen.dart';
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

  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => ProviderScope(
  //     child: MyApp(),
  //   ),
  // ));
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
      // locale: DevicePreview.of(context).locale,
      // builder: DevicePreview.appBuilder,
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
        'showOnBoardScreen': (context) => OnBoardScreen(),
        'showSplashPage': (context) => SplashPage(),
        Registration.id: (context) => Registration(),
        DashboardScreen.id: (context) => DashboardScreen(),
        BoardScreen.id: (context) => BoardScreen(),
        JoinGame.routeName: (context) => JoinGame(),
        CreatedCategories.routeName: (context) => CreatedCategories(),
        CreateCategory.routeName: (context) => CreateCategory(),
        CreateGame.routeName: (context) => CreateGame(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
        SettingsView.routeName: (context) => SettingsView(),
        ViewQuestions.routeName: (context) =>ViewQuestions(),
      },
    );
  }
}
