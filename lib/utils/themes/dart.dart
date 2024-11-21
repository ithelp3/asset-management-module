import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  fontFamily: 'Poppins',
  dividerColor: Colors.grey,
  dividerTheme: const DividerThemeData(color: Colors.transparent),
  dialogBackgroundColor: const Color(0xFF272d34),
  cardColor: const Color(0xFF272d34),
  scaffoldBackgroundColor: const Color(0xFF263238),
  primaryColor: const Color(0xFF272d34),
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color(0xFF3f87b9),
    primaryContainer: Color(0xFF272d34),
    secondary: Color(0xFF75B7EC)
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xFF272d34),
    backgroundColor: Color(0xFF272d34),
    centerTitle: true,
  ),
  cardTheme: const CardTheme(
    color: Color(0xFF272d34)
  ),
  // useMaterial3: true,
  pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      }
  ),
);