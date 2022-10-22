import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/secreens.dart';
import 'Widgets.dart';

class NewShopConatiner extends StatefulWidget {
  String name;
  String imageLink;
  String city;
  String category;
  var id;
  NewShopConatiner(
      {super.key,
      required this.category,
      required this.city,
      required this.imageLink,
      required this.name,
      required this.id});

  @override
  State<NewShopConatiner> createState() => _NewShopConatinerState();
}

class _NewShopConatinerState extends State<NewShopConatiner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(widget.imageLink),
            width: 100,
            fit: BoxFit.cover,
            height: 100,
          ),
          // ignore: prefer_const_constructors
          VerticalDivider(
            width: 10,
            thickness: 2,
            color: const Color.fromARGB(255, 113, 143, 224),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Text("${widget.city}|${widget.category}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700)),
              ],
            ),
          ),
          isAdmin == true
              ? IconButton(
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Scaffold(
                        backgroundColor: Colors.black54,
                        body: Container(
                          color: Colors.white,
                          height: 530,
                          width: double.infinity,
                          child: SafeArea(
                            child: UpdatingButton(
                              discontAmount: "",
                              wantDiscont: false,
                              collection: 'shops',
                              wantPrise: false,
                              price: "",
                              category: widget.category,
                              city: widget.city,
                              imageLink: widget.imageLink,
                              id: widget.id,
                              name: widget.name,
                              Title: "shop",
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
                        .collection('shops')
                        .doc(widget.id);
                    docUser.delete();
                  },
                  icon: const Icon(Icons.delete),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
