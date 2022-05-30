import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rideok2/assistant_methods.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/authentication/login/login_screen.dart';
import 'package:rideok2/screens/authentication/signup/signup.dart';
import 'package:rideok2/screens/main_screen.dart';
import 'package:rideok2/screens/tabs/map.dart';


class MySplashScreen extends StatefulWidget {
  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
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
