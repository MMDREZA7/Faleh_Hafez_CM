import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.green.shade800,
    onBackground: Colors.green.shade300,
    primary: Colors.green.shade900,
    secondary: Colors.grey.shade300,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    primaryContainer: Colors.green,
  ),
);
