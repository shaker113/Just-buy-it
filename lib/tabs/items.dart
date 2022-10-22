import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget.dart/Widgets.dart';

class ItemsTab extends StatefulWidget {
  const ItemsTab({super.key});

  @override
  State<ItemsTab> createState() => _ItemsTabState();
}

class _ItemsTabState extends State<ItemsTab> {
  final CollectionReference CRUDITEMS =
      FirebaseFirestore.instance.collection('items');
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: AddItemContainer(
            theText: "Add your Item Now",
            onTap: () {
              showGeneralDialog(
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Scaffold(
                  backgroundColor: Colors.black54,
                  body: Container(
                    color: Colors.white,
                    height: 631,
                    width: double.infinity,
                    child: SafeArea(
                      child: Adding(
                        wantDiscont: true,
                        wantPrise: true,
                        collection: 'items',
                        title: "item",
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(
          height: 10,
          thickness: 2,
        ),
        StreamBuilder(
          stream: CRUDITEMS.snapshots(),
          // initialData: ,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapShot) {
            if (streamSnapShot.hasData) {
              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                  return NewItemContainer(
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
    );
  }
}
