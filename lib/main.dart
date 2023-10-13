import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
              fontWeight: FontWeight.bold,
            ),
          ),
          titleMedium: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          bodyMedium: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              fontSize: 16,
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Unitastic',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/collegestudents.svg',
              semanticsLabel: 'College Students',
              width: 250,
            ),
            const SizedBox(height: 16),
            Text(
              'A one-stop solution for all your university needs',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Divider(
              color: Theme.of(context).colorScheme.tertiary,
              thickness: 4,
            ),
            const SizedBox(height: 16),
            Text('Unitastic is a collection of tools and utilities that will '
                'help you get through your university life with ease. From '
                'calculating your SGPA to finding out number of classes you '
                'can skip, Unitastic has it all.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Unitastic also provides you with all the materials you need for '
                  'your university life, be it notes, previous question papers,'
                  ' or even textbooks.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.tertiary,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.background,
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  Theme.of(context).textTheme.titleMedium!,
                ),
              ),
              child: const Text('Get Materials'),
            ),
          ],
        ),
      ),
    );
  }
}

