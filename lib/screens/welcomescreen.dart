import 'package:flutter/material.dart';
import 'package:myapp/widget.dart/Widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "JUST BUY IT",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const Image(
                image: AssetImage(
                  "assets/images/welcome.jpg",
                ),
                fit: BoxFit.cover,
              ),
              const Text(
                "Best place to Buy and sell Online",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 140,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customElevatedBotton(
                      theFunction: () {
                        Navigator.pushNamed(context, "register");
                      },
                      theText: "Sign Up"),
                  customElevatedBotton(
                      theFunction: () {
                        Navigator.pushNamed(context, "login");
                      },
                      theText: "Sign in")
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "HomeScreen");
                  },
                  child: Text("sign in as gest"))
            ],
          ),
        ),
      ),
    );
  }
}
