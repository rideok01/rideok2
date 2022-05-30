import 'package:flutter/material.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/splash_screen.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () =>{fAuth.signOut(),
            Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen())),}
          ,
        child: Container(
          width: 266.0,
          height: 51.0,
          child:
              Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
            Positioned(
              left: 0.0,
              top: 0.0,
              right: null,
              bottom: null,
              width: 266.0,
              height: 51.0,
              child: Container(
                width: 266.0,
                height: 51.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(33.0),
                  child: Container(
                    color: Color.fromARGB(255, 104, 149, 251),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 90.0000228881836,
              top: 11.0,
              right: null,
              bottom: null,
              width: 92.00000762939453,
              height: 34.0,
              child: Text(
                '''Sign Out''',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.171875,
                  fontSize: 24.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
