import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final primaryColor = Hexcolor('#1C1046');
final secondaryColor = Hexcolor('#38208C');
final tertiaryColor = Hexcolor('#18C5D9');
final greenColor = Hexcolor('#86EC88');
final redColor = Hexcolor('#FF4D55');
final yellowColor = Hexcolor('#FFDD00');
final accentColor = Hexcolor('#574E76');

final primaryColorDark = Hexcolor('#000000');
final secondaryDarkColor = Hexcolor('#4C4C4C');
final accentDarkColor = Hexcolor('#2B2B2B');

final themeLight = ThemeData(
  colorScheme: ColorScheme(
    primary: primaryColor,
    primaryVariant: primaryColor,
    secondary: secondaryColor,
    secondaryVariant: accentColor,
    surface: greenColor,
    background: primaryColor,
    error: yellowColor,
    onBackground: primaryColor,
    onSurface: secondaryColor,
    onPrimary: accentColor,
    onSecondary: Colors.white,
    onError: redColor,
    brightness: Brightness.light,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins'
);

final themeDark = ThemeData(
  colorScheme: ColorScheme(
      primary: primaryColorDark,
      primaryVariant: primaryColor,
      secondary: secondaryDarkColor,
      secondaryVariant: accentDarkColor,
      surface: greenColor,
      background: primaryColor,
      error: yellowColor,
      onBackground: primaryColor,
      onSurface: secondaryColor,
      onPrimary: accentColor,
      onSecondary: Colors.white,
      onError: redColor,
      brightness: Brightness.light),
  selectedRowColor: greenColor,
  primaryColor: primaryColorDark,
  backgroundColor: primaryColorDark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  fontFamily: 'Poppins'

);

class CustomTheme with ChangeNotifier {
  bool light = true;

  ThemeMode currentTheme() {
    return light ? ThemeMode.light : ThemeMode.dark;
  }

  void darkTheme() {
    light = false;
    notifyListeners();
  }

   void lightTheme() {
    light = true;
    notifyListeners();
  }
}
