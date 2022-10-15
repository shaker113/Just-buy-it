import 'package:flutter/material.dart';
import 'screens/secreens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// this app should work on web
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Cairo'),
      routes: {
        "register": (context) => const RegisterScreen(),
        "login": (context) => const LogInScreen(),
        "HomeScreen": (context) => const HomeScreen(),
      },
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreen();
  }
}
