import 'package:flutter/material.dart';

class myText extends StatelessWidget {
  final theText;
  const myText({super.key, required this.theText});

  @override
  Widget build(BuildContext context) {
    return Text(
      theText,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class myTabText extends StatelessWidget {
  final theText;
  const myTabText({super.key, required this.theText});

  @override
  Widget build(BuildContext context) {
    return Text(
      theText,
      style:
          const TextStyle(fontSize: 18, height: 2, fontWeight: FontWeight.w600),
    );
  }
}
