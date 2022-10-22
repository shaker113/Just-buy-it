import 'package:flutter/material.dart';

Widget GoogleLogInButton(String TheText, Function() theFunction) {
  return ElevatedButton(
    onPressed: theFunction,
    style: ElevatedButton.styleFrom(
        fixedSize: const Size(310, 45),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 5,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 0.8),
            borderRadius: BorderRadius.circular(10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Image(
          image: AssetImage("assets/images/google-logo.png"),
          height: 35,
        ),
        Text(
          TheText,
          style: TextStyle(
            fontSize: 23,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}
