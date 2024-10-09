import 'package:flutter/material.dart';

class AppTheme {
  static Color darkBlue = const Color.fromRGBO(13, 9, 39, 1);
  // light theme
  static final ThemeData lightTheme = ThemeData(
      fontFamily: 'Montserrat',
      primaryColor: const Color(0xFF398AE5),
      scaffoldBackgroundColor: const Color.fromARGB(255, 53, 123, 255),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ));

  // dark theme
  static final ThemeData darkTheme = ThemeData(
      fontFamily: 'Montserrat',
      primaryColor: const Color(0xFF478DE0),
      scaffoldBackgroundColor: const Color.fromRGBO(13, 9, 39, 1),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color.fromARGB(255, 16, 104, 211),
      ));
}
