import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData mainTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF222831),
    secondary: const Color(0xFF393E46),
    tertiary: const Color(0xFF00ADB5),
    background: const Color(0xFFEEEEEE),
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
  useMaterial3: true,
);