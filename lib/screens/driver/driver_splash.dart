import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/authentication/login/login_screen.dart';
import 'package:rideok2/screens/authentication/signup/car_info.dart';
import 'package:rideok2/screens/authentication/signup/signup.dart';
import 'package:rideok2/screens/driver/driver_home.dart';
import 'package:rideok2/screens/main_screen.dart';
import 'package:rideok2/screens/navigation_sidebar.dart';
import 'package:rideok2/screens/tabs/ratings.dart';

class DriverSplash extends StatefulWidget {
  @override
  State<DriverSplash> createState() => _DriverSplashState();
}

class _DriverSplashState extends State<DriverSplash> {
  startTimer() {
    Timer(const Duration(seconds: 1), () async { 
     if(currentFirebaseUser != null)
    {
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(currentFirebaseUser!.uid).once().then((driverKey)
      {
        final snap = driverKey.snapshot;
        if(snap.value != null)
        {
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> DriverHome()));
        }
        else
        {
          Fluttertoast.showToast(msg: "Please enter your car details");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfo()));
        }
      });
    }});
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png', width: 150, height: 150,),
              const SizedBox(height: 10,),
              const Text(
                'RideOK',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),        
              )
    
            ],
          ),
        ),
      ),
    );
  }
}