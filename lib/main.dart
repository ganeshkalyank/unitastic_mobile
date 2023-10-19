import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:unitastic_mobile/theme.dart';
import 'package:unitastic_mobile/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unitastic_mobile/firebase_options.dart';

Future<void> main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: binding);
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
