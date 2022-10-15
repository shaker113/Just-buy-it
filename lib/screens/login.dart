// ignore_for_file: use_build_context_synchronously, duplicate_ignore, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/homePage.dart';

import '../widget.dart/Widgets.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController Email = TextEditingController();
  TextEditingController PassWord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(
              height: 50,
            ),
            const myText(theText: "Sign in"),
            const SizedBox(
              height: 100,
            ),
            const myText(theText: "please enter your Email"),
            customTextField(
                visbleText: false,
                hint: "Email",
                inputType: TextInputType.emailAddress,
                TheController: Email),
            const SizedBox(
              height: 20,
            ),
            const myText(theText: "please enter your password"),
            customTextField(
              visbleText: true,
              hint: "Password",
              inputType: TextInputType.visiblePassword,
              TheController: PassWord,
            ),
            const SizedBox(
              height: 25,
            ),
            customElevatedBotton(
              theFunction: () async {
                try {
                  var authenticationObject = FirebaseAuth.instance;
                  UserCredential myUser =
                      await authenticationObject.signInWithEmailAndPassword(
                          email: Email.text, password: PassWord.text);

                  Navigator.push(context, MaterialPageRoute(
                    //We CAnt Use pushNamed in ((async))
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ));
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("signed in successfully"),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("The email address or password is wrong"),
                    ),
                  );
                }
              },
              theText: "Sign in",
            )
          ],
        ),
      ),
    );
  }
}
