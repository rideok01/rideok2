import 'package:flutter/material.dart'  hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:rideok2/screens/driver/driver_home.dart';

class HomeButton3 extends StatefulWidget {

  @override
  State<HomeButton3> createState() => _HomeButton3State();
}

class _HomeButton3State extends State<HomeButton3> {
     bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    
    Offset distance = isPressed ? Offset(10, 10) : Offset(5, 5);
   double blur = isPressed ? 5.0 : 10.0;

    return GestureDetector(
      onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (c)=>DriverHome())),
        child: Listener(
          onPointerUp: (_) => setState(() =>  isPressed=false),
          onPointerDown: (_) => setState(() =>  isPressed=true),
          child: AnimatedContainer(
            width: 103,
            height: 27,
            duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(242, 242, 242, 1),
            boxShadow: [
              BoxShadow(
                blurRadius: blur,
                offset: distance,
                color: Color(0xFFA7A9AF),
                inset: isPressed,
              ),
              BoxShadow(
                blurRadius: blur,
                offset: -distance,
                color: Colors.white,
                inset: isPressed,
              ),
              
            ]),
      child: GestureDetector(
        onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (c)=>DriverHome())),
        child: Text(
                '''Offer Ride''',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.75,
                  fontSize: 14.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
      ),
    ),
        ));
  }
}