// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widget.dart/Widgets.dart';

class MyItems extends StatefulWidget {
  const MyItems({super.key});

  @override
  State<MyItems> createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  final CollectionReference CRUDITEMS =
      FirebaseFirestore.instance.collection('items');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 113, 143, 224),
        title: const Text("Your added Items"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            StreamBuilder(
              stream: CRUDITEMS
                  .where("id",
                      isEqualTo:
                          FirebaseAuth.instance.currentUser?.uid.toString())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> streamSnapShot) {
                if (streamSnapShot.hasData) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: streamSnapShot.data!.docs.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 5,
                        thickness: 2,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapShot.data!.docs[index];
                      return MyNewItemContainer(
                        discontAmount: documentSnapshot['discontAmount'],
                        discont: documentSnapshot['discont'],
                        price: documentSnapshot['price'],
                        id: documentSnapshot.id,
                        category: documentSnapshot['category'],
                        city: documentSnapshot['city'],
                        imageLink: documentSnapshot['imageLink'],
                        name: documentSnapshot['name'],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "There is nothing here yet :(",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyNewItemContainer extends StatefulWidget {
  final String name;
  final String imageLink;
  final String city;
  final String category;
  final String price;
  String discontAmount;

  final bool discont;

  var id;
  MyNewItemContainer(
      {super.key,
      required this.id,
      required this.category,
      required this.city,
      required this.imageLink,
      required this.name,
      required this.price,
      required this.discont,
      required this.discontAmount});

  @override
  State<MyNewItemContainer> createState() => _MyNewItemContainerState();
}

class _MyNewItemContainerState extends State<MyNewItemContainer> {
  @override
  Widget build(BuildContext context) {
    double newPrice;
    widget.discont
        ? newPrice = (1 - ((double.parse(widget.discontAmount)) / 100)) *
            (double.parse(widget.price))
        : newPrice = 0;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 170,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(widget.imageLink),
            width: 140,
            fit: BoxFit.cover,
            height: 140,
          ),
          const VerticalDivider(
            width: 10,
            thickness: 2,
            color: Color.fromARGB(255, 113, 143, 224),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Text(widget.category,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700)),
                Text(widget.city,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "BUY",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green),
                    ),
                    Column(
                      children: [
                        Text(
                          "${widget.price} JOD",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: widget.discont
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontWeight: FontWeight.w500,
                              color:
                                  widget.discont ? Colors.red : Colors.green),
                        ),
                        widget.discont
                            ? Text(
                                "${double.parse(newPrice.toStringAsFixed(2))} JOD",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Scaffold(
                            backgroundColor: Colors.black54,
                            body: Container(
                              color: Colors.white,
                              // height: 631,
                              width: double.infinity,
                              child: SafeArea(
                                child: UpdatingButton(
                                  discontAmount: widget.discontAmount,
                                  wantDiscont: widget.discont,
                                  collection: 'items',
                                  price: widget.price,
                                  wantPrise: true,
                                  category: widget.category,
                                  city: widget.city,
                                  imageLink: widget.imageLink,
                                  id: widget.id,
                                  name: widget.name,
                                  Title: "item",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        final docUser = FirebaseFirestore.instance
                            .collection('items')
                            .doc(widget.id);
                        docUser.delete();
                        FirebaseStorage.instance
                            .refFromURL(widget.imageLink)
                            .delete();
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
