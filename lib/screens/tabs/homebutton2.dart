import 'package:flutter/material.dart'  hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:rideok2/screens/tabs/map.dart';

class HomeButton2 extends StatefulWidget {

  @override
  State<HomeButton2> createState() => _HomeButton2State();
}

class _HomeButton2State extends State<HomeButton2> {
   bool isPressed = false;
  
  @override
  Widget build(BuildContext context) {
   Offset distance = isPressed ? const Offset(10, 10) : const Offset(5, 5);
   double blur = isPressed ? 5.0 : 10.0;
    return GestureDetector(
      onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (c)=>MapPage())),
        child: Listener(
          onPointerUp: (_) => setState(() =>  isPressed=false),
          onPointerDown: (_) => setState(() =>  isPressed=true),
          child: AnimatedContainer(
            width: 103,
            height: 27,
            duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(242, 242, 242, 1),
            boxShadow: [
              BoxShadow(
                blurRadius: blur,
                offset: distance,
                color: const Color(0xFFA7A9AF),
                inset: isPressed,
              ),
              BoxShadow(
                blurRadius: blur,
                offset: -distance,
                color: Colors.white,
                inset: isPressed,
              ),
              
            ]),
      child: const Text(
              '''Find on Map''',
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
        ));
  }
}