import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitastic_mobile/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
      ),
      home: const HomePage(),
    );
  }
}
