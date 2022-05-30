import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rideok2/assistant_methods.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/authentication/login/login_screen.dart';
import 'package:rideok2/screens/authentication/signup/signup.dart';
import 'package:rideok2/screens/main_screen.dart';

class MySplashCheck extends StatefulWidget {
  @override
  State<MySplashCheck> createState() => _MySplashCheckState();
}

class _MySplashCheckState extends State<MySplashCheck> {

  LocationPermission? _locationPermission;
  Position? userCurrentPosition;
  var geoLocator = Geolocator();

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateMainScreenUser() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        userCurrentPosition = cPosition;
    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCoOrdinates(
            userCurrentPosition!, context);
    print("this is your address = $humanReadableAddress");
  }

  startTimer() {
 fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;    Timer(const Duration(seconds: 3), () async { 

     if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
      }
    });
  }
  

  @override
  void initState() {
    super.initState();
    startTimer();
    checkIfLocationPermissionAllowed();
    locateMainScreenUser();
    
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
            ],
          ),
        ),
      ),
    );
  }
}