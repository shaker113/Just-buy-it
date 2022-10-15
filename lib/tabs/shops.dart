import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widget.dart/Widgets.dart';

class ShopsTab extends StatefulWidget {
  const ShopsTab({super.key});

  @override
  State<ShopsTab> createState() => _ShopsTabState();
}

class _ShopsTabState extends State<ShopsTab> {
  final CollectionReference CRUDSHOPS =
      FirebaseFirestore.instance.collection('shops');
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: AddItemContainer(
            theText: "Open your Shop Now",
            onTap: () {
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
                      child: Adding(
                        wantPrise: false,
                        collection: 'shops',
                        title: "shop",
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
          stream: CRUDSHOPS.snapshots(),
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
                  return NewShopConatiner(
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
    );
  }
}
