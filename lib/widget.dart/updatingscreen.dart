import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'Widgets.dart';

class UpdatingButton extends StatefulWidget {
  late String? Title;
  var id;
  String category;
  String city;
  String imageLink;
  String name;
  bool wantPrise;
  bool wantDiscont;
  String price;
  String collection;
  String discontAmount;

  UpdatingButton(
      {super.key,
      required this.wantDiscont,
      required this.discontAmount,
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
  File? image;
  var imagepiker = ImagePicker();
  var storgeRef;

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    name.text = widget.name;
    TextEditingController imageLink = TextEditingController();
    imageLink.text = widget.imageLink;
    TextEditingController price = TextEditingController();
    price.text = widget.price;
    TextEditingController discontAmount = TextEditingController();
    discontAmount.text = widget.discontAmount;
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
            const Text("image"),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: customAddElevatedBotton(
                  theFunction: () async {
                    var random = Random().nextInt(1000000000);
                    var imagepiked =
                        await imagepiker.pickImage(source: ImageSource.gallery);
                    if (imagepiked != null) {
                      setState(
                        () {
                          image = File(imagepiked.path);
                        },
                      );

                      var imageName = basename(imagepiked.path);
                      storgeRef = FirebaseStorage.instance
                          .ref("images/$random$imageName");
                    }
                  },
                  theText: "Upload an image"),
            ),
            const SizedBox(
              height: 10,
            ),
            image != null
                ? Image.file(
                    image!,
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image(
                    image: NetworkImage(widget.imageLink),
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            if (widget.wantPrise)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 5, child: const Text("Price")),
                      Expanded(flex: 1, child: const Text("Discont")),
                      Switch(
                          value: widget.wantDiscont,
                          onChanged: (value) {
                            setState(() {
                              widget.wantDiscont = !widget.wantDiscont;
                            });
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: widget.wantDiscont ? 2 : 99,
                        child: customTextField(
                            theFormater: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]')),
                            ],
                            TheController: price,
                            hint: "Price in JOD",
                            visbleText: false,
                            inputType: const TextInputType.numberWithOptions(
                                decimal: true)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: widget.wantDiscont
                              ? customTextField(
                                  theFormater: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2)
                                    ],
                                  TheController: discontAmount,
                                  hint: "Discont amount",
                                  visbleText: false,
                                  inputType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true))
                              : const SizedBox())
                    ],
                  ),
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
                customAdminElevatedBotton(
                    theFunction: () async {
                      String? imageUrl;
                      if (image != null) {
                        await storgeRef.putFile(image);
                        imageUrl = await storgeRef.getDownloadURL();
                      }
                      final docUser = FirebaseFirestore.instance
                          .collection(widget.collection)
                          .doc(widget.id);
                      docUser.update({
                        'name': name.text,
                        'city': chosenCity,
                        'category': chosenCategory,
                        'imageLink':
                            image != null ? imageUrl : widget.imageLink,
                        'price': price.text,
                        'discont': widget.wantDiscont,
                        'discontAmount': discontAmount.text
                      });
                      if (image != null) {
                        FirebaseStorage.instance
                            .refFromURL(widget.imageLink)
                            .delete();
                      }
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
