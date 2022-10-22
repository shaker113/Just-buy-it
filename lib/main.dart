import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/secreens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

bool? isLogin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogin = false;
   
  } else {
    isLogin = true;
   
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Cairo'),
        routes: {
          "HomeScreen": (context) => const HomeScreen(),
          "register": (context) => const RegisterScreen(),
          "login": (context) => const LogInScreen(),
          "WelcomeScreen": (context) => const WelcomeScreen(),
          "resetPassword": (context) => const ResetPasswordScreen(),
          "usersScreen": (context) => const UserScreen(),
        },
        home: isLogin == true ? const HomeScreen() : const WelcomeScreen());
  }
}
