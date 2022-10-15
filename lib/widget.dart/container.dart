import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  double myWidth;
  double myHeight;
  String imageLink;
  String theText;
  CategoryContainer(
      {super.key,
      required this.theText,
      required this.imageLink,
      required this.myHeight,
      required this.myWidth});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageLink), fit: BoxFit.cover)),
          width: myWidth,
          height: myHeight,
        ),
        Container(
          width: myWidth,
          height: myHeight,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            theText,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ShopsContainer extends StatefulWidget {
  const ShopsContainer({super.key});

  @override
  State<ShopsContainer> createState() => _ShopsContainerState();
}

class _ShopsContainerState extends State<ShopsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AddItemContainer extends StatelessWidget {
  String theText;
  Function() onTap;
  AddItemContainer({super.key, required this.theText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 156, 18),
            borderRadius: BorderRadius.circular(7)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
          Text(
            theText,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          )
        ]),
      ),
    );
  }
}
