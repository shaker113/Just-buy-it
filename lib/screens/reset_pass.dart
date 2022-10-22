// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widget.dart/Widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController Email = TextEditingController();
  TextEditingController PassWord = TextEditingController();
  TextEditingController PassWordAgain = TextEditingController();

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
            const myText(theText: "Reset your Password"),
            const SizedBox(
              height: 100,
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
            customElevatedBotton(
                theFunction: () {
                  passwordReset();
                },
                theText: "Reset Password")
          ],
        ),
      ),
    );
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: Email.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "please check your email and click on the provided link to reset your password"),
        ),
      );
      Navigator.pushNamed(context, "login");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Something went!! wrong please make sure you entered the correct email"),
        ),
      );
      print(e);
    }
  }
}
