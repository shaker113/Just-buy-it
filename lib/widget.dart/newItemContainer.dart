import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/homePage.dart';

import 'Widgets.dart';

class NewItemContainer extends StatefulWidget {
  final String name;
  final String imageLink;
  final String city;
  final String category;
  final String price;
  String discontAmount;
  final bool discont;
  String id;
  NewItemContainer(
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
  State<NewItemContainer> createState() => _NewItemContainerState();
}

class _NewItemContainerState extends State<NewItemContainer> {
  @override
  Widget build(BuildContext context) {
    double newPrice;
    widget.discont
        ? newPrice = (1 - ((double.parse(widget.discontAmount)) / 100)) *
            (double.parse(widget.price))
        : newPrice = 0;
    String? username;
    getUserName() async {
      DocumentSnapshot userinfo = await FirebaseFirestore.instance
          .collection('items')
          .doc(widget.id)
          .get();
      String userid = userinfo['id'];
      DocumentSnapshot userinfo1 =
          await FirebaseFirestore.instance.collection('user').doc(userid).get();
      print(userinfo1['name']);

      setState(() {
        username = userinfo1['name'];
      });
    }

    // @override
    // void initState() {
    //   getUserName();
    //   super.initState();
    // }

    return Container(
      margin: EdgeInsets.only(top: 10),
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
                username != null
                    ? Text("seller : ${username}}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800))
                    : SizedBox(),
                Text("${widget.city}|${widget.category}",
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
                    isAdmin == true
                        ? IconButton(
                            onPressed: () {
                              showGeneralDialog(
                                context: context,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Scaffold(
                                  backgroundColor: Colors.black54,
                                  body: Container(
                                    color: Colors.white,
                                    height: 631,
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
                          )
                        : const SizedBox(),
                    isAdmin == true
                        ? IconButton(
                            onPressed: () {
                              final docUser = FirebaseFirestore.instance
                                  .collection('items')
                                  .doc(widget.id);
                              docUser.delete();
                            },
                            icon: const Icon(Icons.delete),
                          )
                        : const SizedBox(),
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
