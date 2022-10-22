// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'Widgets.dart';
import 'package:path/path.dart';

class Adding extends StatefulWidget {
  String title;
  String collection;
  bool wantPrise;
  bool wantDiscont;

  Adding(
      {super.key,
      required this.title,
      required this.wantDiscont,
      required this.collection,
      required this.wantPrise});

  @override
  State<Adding> createState() => _AddingState();
}

class _AddingState extends State<Adding> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discontAmount = TextEditingController();
  TextEditingController imageLink = TextEditingController();
  File? image;
  var imagepiker = ImagePicker();
  var storgeRef;

  // uploadImage() async {
  //   var imagepiked = await imagepiker.pickImage(source: ImageSource.gallery);
  //   if (imagepiked != null) {
  //     var random = Random().nextInt(1000000000);
  //     file = File(imagepiked.path);
  //     var imageName = basename(imagepiked.path);
  //     var storgeRef = FirebaseStorage.instance.ref("images/$random$imageName");
  //     await storgeRef.putFile(file!);
  //     var imageUrl = await storgeRef.getDownloadURL();
  //     print(imageUrl);
  //   } else
  //     print("wrog");
  // }

  @override
  Widget build(BuildContext context) {
    List citys = ["Amman", "Aqaba", "Irbid", "Zarqa", "Madaba", "Jerash"];
    String chosenCity = "Amman";
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
    bool wantDiscont = false;
    String chosenCategory = "Cars and Bikes";
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myText(
                  theText:
                      "Please fill the information of your ${widget.title}"),
              const SizedBox(
                height: 20,
              ),
              Text("${widget.title} name"),
              const SizedBox(
                height: 10,
              ),
              customTextField(
                  hint: "${widget.title} name",
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
                      var imagepiked = await imagepiker.pickImage(
                          source: ImageSource.gallery);
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
                  : const Center(child: Text("No image has uploaded yet")),
              if (widget.wantPrise)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(flex: 5, child: Text("Price")),
                        const Expanded(flex: 1, child: Text("Discont")),
                        Switch(
                            value: wantDiscont,
                            onChanged: (value) {
                              setState(() {
                                wantDiscont = !wantDiscont;
                              });
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: wantDiscont ? 2 : 99,
                          child: customTextField(
                              theFormater: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              TheController: price,
                              hint: "Price",
                              visbleText: false,
                              inputType: const TextInputType.numberWithOptions(
                                  decimal: true)),
                        ),
                        SizedBox(
                          width: wantDiscont ? 10 : 0,
                        ),
                        Expanded(
                            flex: 1,
                            child: wantDiscont
                                ? customTextField(
                                    theFormater: [
                                        FilteringTextInputFormatter.digitsOnly
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
              const SizedBox(
                height: 5,
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
                        try {
                          await storgeRef.putFile(image!);
                          var imageUrl = await storgeRef.getDownloadURL();
                          createUser(
                              id: FirebaseAuth.instance.currentUser?.uid,
                              discont: wantDiscont,
                              discontAmount: discontAmount.text,
                              price: price.text,
                              name: name.text,
                              city: chosenCity,
                              category: chosenCategory,
                              imageLink: imageUrl,
                              collection: widget.collection);
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "There is something went wrong please try again"),
                            ),
                          );
                        }
                        Navigator.pop(context);
                      },
                      theText: "Add your ${widget.title}")
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future createUser(
      {required String name,
      required String? id,
      required String city,
      required String discontAmount,
      required bool discont,
      required String category,
      required String imageLink,
      required String price,
      required String collection}) async {
    final User = FirebaseFirestore.instance.collection(collection).doc();

    final json = {
      'id': id,
      'name': name,
      'city': city,
      'price': price,
      'category': category,
      'imageLink': imageLink,
      'discontAmount': discontAmount,
      'discont': discont,
    }; //to Create doucumant
    await User.set(json);
  }
}
