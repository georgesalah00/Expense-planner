import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    fontFamily: 'QuickSand',
    textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.blue),
        titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 20)));
CupertinoThemeData iosLightTheme = CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.purple,
);
