import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.green.shade500,
    onPrimary: Colors.green.shade900,
    background: Colors.green.shade300,
    onBackground: Colors.green.shade900,
    secondary: Colors.green.shade300,
    onSecondary: Colors.green.shade900,

    // for gradiant
    primaryContainer: Colors.green,
    onPrimaryContainer: Colors.yellow,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.green.shade900,
    onPrimary: Colors.green.shade300,
    background: Colors.green.shade800,
    onBackground: Colors.green.shade500,
    secondary: Colors.green.shade800,
    onSecondary: Colors.green.shade300,

    // for gradiant
    primaryContainer: Colors.green,
    onPrimaryContainer: Colors.green,
  ),
);
