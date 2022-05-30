// ignore_for_file: prefer_adjacent_string_concatenation

import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:rideok2/screens/authentication/global.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  var userId = currentFirebaseUser?.uid;
  var userName = currentFirebaseUser?.displayName;
  var userEmail = currentFirebaseUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: FutureBuilder(
                future: _fetch(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'))
                            .pOnly(right: 12),
                        Expanded(
                            child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Text("Name : " + "Random Name"),
                              const Spacer(),
                              Text("Email : ${snapshot.data.email}"),
                              const Spacer(),
                              const Text("Phone : " + "Random Phone Number"),
                              const Spacer(),
                              Text(
                                "ID : ${snapshot.data.uid}",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ))
                      ],
                    ).pOnly(left: 12, right: 12);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80,
                        decoration:
                            const BoxDecoration(color: Colors.orangeAccent),
                        child: Text(index.toString()).centered(),
                      ).p(8);
                    }))
          ],
        ),
      ),
    );
  }

  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }
}
