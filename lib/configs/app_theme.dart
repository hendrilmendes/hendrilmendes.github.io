// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTheme {
  static const Color cBackground = Color(0xff0a192f);

  static const Color cPrimary = Color(0xFF64FFDA);

  static const Color cSecondary = Color(0xFF8892B0);

  static const Color cLight = Colors.white;

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: cBackground,

    colorScheme: const ColorScheme.dark(
      primary: cPrimary,
      secondary: cPrimary,
      surface: cBackground,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: cLight,
    ),

    textTheme: ThemeData.dark().textTheme
        .apply(
          fontFamily: 'Poppins',
          bodyColor: cSecondary,
          displayColor: cLight,
        )
        .copyWith(
          headlineLarge: const TextStyle(
            color: cLight,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          headlineMedium: const TextStyle(
            color: cPrimary,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: const TextStyle(
            color: cSecondary,
            height: 1.6,
            fontSize: 16,
          ),
        ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: cLight),
      titleTextStyle: TextStyle(
        color: cLight,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: cPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: cPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        side: const BorderSide(color: cPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: cPrimary.withOpacity(0.2),
      side: BorderSide(color: cPrimary.withOpacity(0.5)),
      labelStyle: const TextStyle(
        color: cLight,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );
}
