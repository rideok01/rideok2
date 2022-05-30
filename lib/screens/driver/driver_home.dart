import 'package:flutter/material.dart'  hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/navigation_sidebar.dart';
import 'package:rideok2/screens/tabs/driverswitch.dart';
import 'package:rideok2/screens/tabs/homebutton1.dart';


class DriverHome extends StatefulWidget {
  @override
  State<DriverHome> createState() => _DriverHomeState();
 
}

class _DriverHomeState extends State<DriverHome> {
   
  
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 07),
          child: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                "assets/icons/drawer.svg",
                height: 45,
                width: 44,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      drawer: MainNavigation(
        namee: userModelCurrentInfo!.name,
        emaill: userModelCurrentInfo!.email,
      ),
      body: DriverSwitch(),
    );
  }
}
