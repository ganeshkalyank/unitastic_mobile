import 'package:flutter/material.dart';
import 'package:unitastic_mobile/theme.dart';
import 'package:unitastic_mobile/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unitastic_mobile/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unitastic',
      theme: mainTheme,
      home: const HomePage(),
    );
  }
}
