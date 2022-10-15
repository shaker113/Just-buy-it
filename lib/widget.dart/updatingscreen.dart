import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Widgets.dart';

class UpdatingButton extends StatefulWidget {
  late String? Title;
  var id;
  String category;
  String city;
  String imageLink;
  String name;
  bool wantPrise;
  String price;
  String collection;

  UpdatingButton(
      {super.key,
      required this.Title,
      required this.id,
      required this.name,
      required this.category,
      required this.city,
      required this.wantPrise,
      required this.imageLink,
      required this.price,
      required this.collection});

  @override
  State<UpdatingButton> createState() => _UpdatingButtonState();
}

class _UpdatingButtonState extends State<UpdatingButton> {
  List citys = ["Amman", "Aqaba", "Irbid", "Zarqa", "Madaba", "Jerash"];
  late String chosenCity = widget.city;
  List categories = [
    "Cars and Bikes",
    "Mobile-Tablet",
    "Video Games & Consoles",
    "Electronics-Appliances",
    "Computers& Laptops",
    "Home & Garden",
    "Men's Fashion",
    "Women's Fashion",
  ];
  late String chosenCategory = widget.category;

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    name.text = widget.name;
    TextEditingController imageLink = TextEditingController();
    imageLink.text = widget.imageLink;
    TextEditingController price = TextEditingController();
    price.text = widget.price;

    return StatefulBuilder(builder: (BuildContext context, setState) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myText(
                theText: "Please fill the information of your ${widget.Title}"),
            const SizedBox(
              height: 20,
            ),
            Text("${widget.Title} name"),
            const SizedBox(
              height: 10,
            ),
            customTextField(
                hint: "${widget.Title} name",
                visbleText: false,
                TheController: name,
                inputType: TextInputType.name),
            const SizedBox(
              height: 10,
            ),
            const Text("image Link"),
            const SizedBox(
              height: 10,
            ),
            customTextField(
                TheController: imageLink,
                hint: "image link",
                visbleText: false,
                inputType: TextInputType.name),
            const SizedBox(
              height: 10,
            ),
            if (widget.wantPrise)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Price"),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextField(
                      TheController: price,
                      hint: "Price",
                      visbleText: false,
                      inputType: TextInputType.number),
                ],
              ),
            const Text("category"),
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
              value: chosenCategory,
              items: categories
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        "$e",
                        style: const TextStyle(color: Colors.black),
                      )))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  chosenCategory = value.toString();
                });
              },
            ),
            const Text("city"),
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
              value: chosenCity,
              items: citys
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        "$e",
                        style: const TextStyle(color: Colors.black),
                      )))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  chosenCity = value.toString();
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customBackElevatedBotton(
                    theFunction: () {
                      Navigator.pop(context);
                    },
                    theText: "Back"),
                customAddElevatedBotton(
                    theFunction: () {
                      final docUser = FirebaseFirestore.instance
                          .collection(widget.collection)
                          .doc(widget.id);
                      docUser.update({
                        'name': name.text,
                        'city': chosenCity,
                        'category': chosenCategory,
                        'imageLink': imageLink.text,
                        'price': price.text
                      });

                      Navigator.pop(context);
                    },
                    theText: "Update your ${widget.Title}")
              ],
            )
          ],
        ),
      );
    });
  }
}
