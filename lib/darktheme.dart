import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFFFFFFFF),
    secondary: const Color(0xFFEEEEEE),
    tertiary: const Color(0xFF00ADB5),
    primaryContainer: const Color(0xFF393E46),
    background: const Color(0xFF222831),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.pacifico(
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleLarge: GoogleFonts.josefinSans(
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    ),
    titleMedium: GoogleFonts.josefinSans(
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    titleSmall: GoogleFonts.josefinSans(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    bodyMedium: GoogleFonts.josefinSans(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
    bodySmall: GoogleFonts.josefinSans(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFF00ADB5),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(8.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    labelStyle: GoogleFonts.josefinSans(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
    hintStyle: GoogleFonts.josefinSans(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),

  ),
  useMaterial3: true,
);