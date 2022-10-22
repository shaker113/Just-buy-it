// ignore_for_file: use_build_context_synchronously, duplicate_ignore, unused_local_variable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widget.dart/Widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController Email = TextEditingController();

    TextEditingController PassWord = TextEditingController();

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

                  Navigator.pushNamed(context,
                      "HomeScreen"); // ignore: use_build_context_synchronously
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
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text("Forgot password?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "resetPassword");
                    },
                    child: const Text("Reset Password"))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 1.5,
                  width: 140,
                  color: Colors.grey,
                ),
                const Text(
                  "OR",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Container(
                  height: 1.5,
                  width: 140,
                  color: Colors.grey,
                ),
              ],
            ),
            GoogleLogInButton("Sign in with your Google ", () async {
              try {
                var user = await signInWithGoogle();
                Navigator.pushNamed(context, "HomeScreen");
              } catch (e) {
                print(e);
              }
            }),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
