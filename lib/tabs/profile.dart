import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/secreens.dart';
import 'package:myapp/widget.dart/bottons.dart';

class profileTab extends StatefulWidget {
  const profileTab({super.key});

  @override
  State<profileTab> createState() => _profileTabState();
}

class _profileTabState extends State<profileTab> {
  CollectionReference user = FirebaseFirestore.instance.collection("user");
  String? userId = FirebaseAuth.instance.currentUser?.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(15),
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: const Color.fromARGB(255, 100, 123, 187),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "account information",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<QuerySnapshot>(
                future: user
                    .where("id",
                        isEqualTo:
                            FirebaseAuth.instance.currentUser?.uid.toString())
                    .get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[0];
                    return Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email : ${documentSnapshot['email']}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Name : ${documentSnapshot['name']}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
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
        const SizedBox(
          height: 50,
        ),
        const Text(
          "To Eddit your items and shops",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customAdminElevatedBotton(
              theText: "my shops",
              theFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyShops(),
                  ),
                );
              },
            ),
            customAdminElevatedBotton(
              theText: "my Items",
              theFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyItems(),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        isAdmin == true
            ? Column(
                children: [
                  const Text(
                    "This is an admin account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  customAdminElevatedBotton(
                      theFunction: () {
                        Navigator.pushNamed(context, "usersScreen");
                      },
                      theText: "User List")
                ],
              )
            : const SizedBox(),
        const SizedBox(
          height: 50,
        ),
        customAdminElevatedBotton(
            theFunction: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "WelcomeScreen");
            },
            theText: "log out")
      ],
    );
  }
}
