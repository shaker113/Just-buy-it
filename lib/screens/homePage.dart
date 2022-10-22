import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tabs/profile.dart';
import 'package:myapp/tabs/tabs.dart';
import 'package:myapp/widget.dart/Text.dart';
import 'package:myapp/widget.dart/textField.dart';

bool? isAdmin;
void checkRole() async {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot userInfo =
      await FirebaseFirestore.instance.collection('user').doc(user?.uid).get();
  String userRole = userInfo['role'];
  userRole == "admin" ? isAdmin = true : isAdmin = false;

}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    checkRole();
    super.initState();
  }

  List citys = ["Amman", "Aqaba", "Irbid", "Zarqa", "Madaba", "Jerash"];
  String chosenCity = "Amman";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 113, 143, 224),
            leadingWidth: 40,
            leading: const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Image(
                  image: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/4175/4175980.png")),
            ),
            actions: [
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
              )
            ],
            toolbarHeight: 50,
            title: const SearchBox(),
            bottom: const TabBar(tabs: [
              myTabText(theText: "home"),
              myTabText(theText: "Shops"),
              myTabText(theText: "Items"),
              myTabText(theText: "profile")
            ]),
          ),
          body: const TabBarView(children: [
            CategoriesTab(),
            ShopsTab(),
            ItemsTab(),
            profileTab()
          ]),
        ),
      ),
    );
  }
}
