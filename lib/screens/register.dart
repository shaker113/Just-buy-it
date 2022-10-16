// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:myapp/widget.dart/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController Email = TextEditingController();
  TextEditingController PassWord = TextEditingController();
  TextEditingController PassWordAgain = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            const myText(theText: "Register your Account"),
            const SizedBox(
              height: 100,
            ),
            const myText(theText: "Name"),
            customTextField(
              visbleText: false,
              hint: "Enter your first name...",
              inputType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),
            const myText(theText: "Email address"),
            customTextField(
                visbleText: false,
                hint: "enter your email address...",
                inputType: TextInputType.emailAddress,
                TheController: Email),
            const SizedBox(
              height: 20,
            ),
            const myText(theText: "password"),
            customTextField(
              visbleText: true,
              hint: "Enter your password...",
              inputType: TextInputType.visiblePassword,
              TheController: PassWord,
            ),
            const SizedBox(
              height: 20,
            ),
            const myText(theText: "Confirm password"),
            customTextField(
                TheController: PassWordAgain,
                visbleText: true,
                hint: "Enter your password again...",
                inputType: TextInputType.visiblePassword),
            const SizedBox(
              height: 25,
            ),
            customElevatedBotton(
              theFunction: () async {
                if (PassWordAgain.text == PassWord.text) {
                  try {
                    var authenticationObject = FirebaseAuth.instance;
                    UserCredential myUser = await authenticationObject
                        .createUserWithEmailAndPassword(
                            email: Email.text, password: PassWord.text);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("sgind up successfully"),
                      ),
                    );
                    Navigator.pushNamed(context, "login");
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "The email address is already in use by another account."),
                      ),
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        actions: [
                          const Text(
                            "you must enter the same password twice in order to confirm it ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22),
                          ),
                          Center(
                            child: customElevatedBotton(
                                theFunction: () {
                                  Navigator.pop(context);
                                },
                                theText: "Okay"),
                          )
                        ],
                      );
                    },
                  );
                }
              },
              theText: "Sign up",
            )
          ],
        ),
      ),
    );
  }
}
