import 'package:flutter/material.dart';

class customElevatedBotton extends StatelessWidget {
  final String theText;
  final Function() theFunction;
  customElevatedBotton(
      {super.key, required this.theFunction, required this.theText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 113, 143, 224),
          fixedSize: const Size(120, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      onPressed: theFunction,
      child: Text(
        theText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class customBackElevatedBotton extends StatelessWidget {
  final String theText;
  final Function() theFunction;
  customBackElevatedBotton(
      {super.key, required this.theFunction, required this.theText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 86, 92, 110),
          fixedSize: const Size(120, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      onPressed: theFunction,
      child: Text(
        theText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class customAddElevatedBotton extends StatelessWidget {
  final String theText;
  final Function() theFunction;
  customAddElevatedBotton(
      {super.key, required this.theFunction, required this.theText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 113, 143, 224),
          fixedSize: const Size(170, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      onPressed: theFunction,
      child: Text(
        theText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class customAdminElevatedBotton extends StatelessWidget {
  final String theText;
  final Function() theFunction;
  customAdminElevatedBotton(
      {super.key, required this.theFunction, required this.theText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 113, 143, 224),
          fixedSize: const Size(170, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      onPressed: theFunction,
      child: Text(
        theText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
