import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  CollectionReference usersInfo = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 113, 143, 224),
        title: Text("User list"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: usersInfo.get(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      List role = ["admin", "user"];
                      String userRole = snapshot.data!.docs[index]['role'];
                      if (snapshot.hasData) {
                        return ListTile(
                          title: Text(
                            "Email: ${snapshot.data?.docs[index]['email']}",
                            style: const TextStyle(fontSize: 15),
                          ),
                          subtitle: Text(
                              "Name: ${snapshot.data?.docs[index]['name']}"),
                          trailing: DropdownButton(
                            items: role
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      "$e",
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: userRole,
                            onChanged: (value) {
                              snapshot.data?.docs[index].reference
                                  .update({'role': value});
                              setState(
                                () {
                                  userRole = value.toString();
                                },
                              );
                            },
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Text(
                            "somthing went Wrong! please check your connection");
                      } else {
                        return const Text("please wait");
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
