// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideok2/assistant_methods.dart';
import 'package:rideok2/models/directions_new.dart';
import 'package:rideok2/models/driver_details.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool _isLoading = false;

  LatLng Hcl = LatLng(28.608585486138754, 77.36293993959215);
  LatLng Amity = LatLng(28.54412733486746, 77.33307631780283);
  Directions_New? points;
  List drivers = [];
  List userPoints = [];
  List availableDrivers = [];
  // List<DriverDetails> drivers = [];

  DatabaseReference testref = FirebaseDatabase.instance
      .ref()
      .child('Amity University Noida')
      .child('rides');

  getPolyLine() async {
    points =
        await AssistantMethods.getDirections(origin: Hcl, destination: Amity);
  }

  Future<void> addLocations() async {
    /// i is for looping through userPoints
    /// j is for looping through all the drivers going to Amity
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < drivers.length; j++) {
        if (Geolocator.distanceBetween(
                    userPoints[userPoints.length * i ~/ 10].latitude,
                    userPoints[0].longitude,
                    drivers[j]['start_lat'],
                    drivers[j]['start_lng']) <
                50000 ||
            Geolocator.distanceBetween(
                    userPoints[userPoints.length * i ~/ 10].latitude,
                    userPoints[0].longitude,
                    drivers[j]['mid_lat'],
                    drivers[j]['mid_long']) <
                50000 ||
            Geolocator.distanceBetween(
                    userPoints[userPoints.length * i ~/ 10].latitude,
                    userPoints[0].longitude,
                    drivers[j]['end_lat'],
                    drivers[j]['end_lng']) <
                50000) {
          print('Drivers are available');
          availableDrivers.add(drivers[j]['key']);
        } else {
          print('Drivers are not available');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  testref.once().then((e) {
                    Map? b = e.snapshot.value as Map?;
                    b!.forEach(
                        (index, data) => drivers.add({"key": index, ...data}));
                    // print(drivers[0]['key']);
                    // print(drivers[0]['start_location']);
                    // print(drivers[0]['end_location']);
                    // print(drivers.length);
                    //print(e.snapshot.key);
                  });

                  await getPolyLine();
                  //print(points!.polylinePoints.toString());
                  // getting a list of LatLng points
                  userPoints = points!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList();
                  // print(userPoints[0].latitude);
                  // print(userPoints[(userPoints.length * 0.3).toInt()]);
                  // print(userPoints[(userPoints.length * 0.6).toInt()]);

                  addLocations();

                  setState(() {
                    availableDrivers = availableDrivers.toSet().toList();
                    print(availableDrivers);
                    _isLoading = false;
                  });
                },
                child: Text("Test"),
              ),
              SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : availableDrivers.isEmpty
                          ? SizedBox()
                          : ListView.builder(
                              itemCount: availableDrivers.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: Colors.green,
                                  child: ListTile(
                                    title: Text(availableDrivers[index]),
                                  ),
                                );
                              }))
            ],
          ),
        ),
      ),
    );
  }
}
