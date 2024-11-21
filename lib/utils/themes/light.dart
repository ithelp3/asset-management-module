import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  canvasColor: const Color(0xFFD1E8FA),
  fontFamily: 'Poppins',
  dividerColor: Colors.grey,
  dividerTheme: const DividerThemeData(color: Colors.transparent),
  scaffoldBackgroundColor: const Color(0xFFECF3F8),
  primaryColor: const Color(0xFF3f87b9),
  // cardColor: const Color(0xFFECF3F8),
  // dialogBackgroundColor: const Color(0xFFECF3F8),
  colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: Color(0xFF3f87b9),
      secondary: Color(0xFF75B7EC),
      primaryContainer: Color(0xFFD1E8FA),
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xFFECF3F8),
    // backgroundColor: Color(0xFF3f87b9),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    }
  ),
  // useMaterial3: true,
);