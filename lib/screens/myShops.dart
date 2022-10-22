import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget.dart/Widgets.dart';

class MyShops extends StatefulWidget {
  const MyShops({super.key});

  @override
  State<MyShops> createState() => _MyShopsState();
}

class _MyShopsState extends State<MyShops> {
  final CollectionReference CRUDSHOPS =
      FirebaseFirestore.instance.collection('shops');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 113, 143, 224),
        title: Text("Your added Shops"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            StreamBuilder(
              stream: CRUDSHOPS
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
                      return MYNewShopConatiner(
                          id: documentSnapshot.id,
                          category: documentSnapshot['category'],
                          city: documentSnapshot['city'],
                          imageLink: documentSnapshot['imageLink'],
                          name: documentSnapshot['name']);
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

class MYNewShopConatiner extends StatefulWidget {
  String name;
  String imageLink;
  String city;
  String category;
  var id;
  MYNewShopConatiner(
      {super.key,
      required this.category,
      required this.city,
      required this.imageLink,
      required this.name,
      required this.id});

  @override
  State<MYNewShopConatiner> createState() => _MYNewShopConatinerState();
}

class _MYNewShopConatinerState extends State<MYNewShopConatiner> {
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
          IconButton(
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
          ),
          IconButton(
            onPressed: () {
              final docUser =
                  FirebaseFirestore.instance.collection('shops').doc(widget.id);
              docUser.delete();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
