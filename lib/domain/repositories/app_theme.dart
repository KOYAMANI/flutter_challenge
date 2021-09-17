import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _primaryColor = Colors.white;
  static const Color _secondaryColor = Colors.blueAccent;

  static const Color _iconColor = Colors.white;

  static final ThemeData customTheme = ThemeData(
    scaffoldBackgroundColor: _primaryColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: _secondaryColor,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    iconTheme: const IconThemeData(
      color: _iconColor,
    ),
    textTheme: _primaryTextTheme,
  );

  static const TextTheme _primaryTextTheme = TextTheme(
    headline1: _primaryHeadlineTextStyle,
    bodyText1: _primaryBodyTextStyle,
  );

  static const TextStyle _primaryHeadlineTextStyle = TextStyle(
    color: _primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _primaryBodyTextStyle = TextStyle(
    color: _primaryColor,
  );
}
