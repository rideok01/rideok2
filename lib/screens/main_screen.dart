import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rideok2/assistant_methods.dart';
import 'package:rideok2/informationhandler/app_info.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/driver/driver_home.dart';
import 'package:rideok2/screens/search_screens/search_places.dart';
import 'package:rideok2/screens/tabs/homebutton1.dart';
import 'package:rideok2/screens/tabs/homebutton2.dart';
import 'package:rideok2/screens/tabs/homebutton3.dart';
import 'package:rideok2/screens/tabs/map.dart';
import 'package:rideok2/screens/user_navigation.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isPressed = false;

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

  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();
    locateMainScreenUser();
  }

  Widget build(BuildContext context) {
    Offset distance = isPressed ? Offset(10, 10) : Offset(5, 5);
    double blur = isPressed ? 5.0 : 10.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(153, 255, 255, 255),
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
      drawer: UserNavigation(
        namee: userModelCurrentInfo!.name,
        emaill: userModelCurrentInfo!.email,
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 103.0,
            top: 0,
            right: null,
            bottom: null,
            width: 267.0,
            height: 190.65196228027344,
            child: Image.asset('assets/images/homepageimg.png'),
          ),
          Positioned(
              left: 17,
              top: 65,
              width: 145,
              height: 176,
              child: Text(
                'Car Pool  ' + 'With            ' + 'the Knowns',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Inter',
                    fontSize: 22,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.25),
              )),
          Positioned(
            top: 213,
            child: Center(
              child: Container(
                width: 350,
                height: 214,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment(0.9797160029411316, 0.03849898651242256),
                      end: Alignment(-0.03849898651242256, 0.04261964559555054),
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: [
                        Color.fromRGBO(0, 209, 255, 0.25999999046325684),
                        Color.fromRGBO(117, 0, 173, 0.3499999940395355)
                      ]),
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    child: Column(
                      children: [
                        //from origin
                        Row(
                          children: [
                            const Icon(CupertinoIcons.location_solid),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "From",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  Provider.of<AppInfo>(context)
                                              .userPickUpLocation !=
                                          null
                                      ? "${(Provider.of<AppInfo>(context).userPickUpLocation!.locationName!).substring(0, 24)}..."
                                      : "your current address",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10.0),

                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        const SizedBox(height: 16.0),

                        //to destination
                        GestureDetector(
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (c)=> SearchPlaces()));
                          },
                          child: Row(
                            children: [
                              const Icon(CupertinoIcons.location_solid),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "To",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  Text(
                                    Provider.of<AppInfo>(context).userDropOffLocation != null 
                                      ? Provider.of<AppInfo>(context).userDropOffLocation!.locationName!
                                      : "Where to go?",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10.0),

                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        const SizedBox(height: 16.0),

                        ElevatedButton(
                          child: const Text(
                            "Request a Ride",
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 146, 182, 244),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
              top: 453,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeButton1(),
                  SizedBox(
                    width: 22,
                  ),
                  HomeButton2(),
                  SizedBox(
                    width: 22,
                  ),
                  HomeButton3(),
                ],
              )),
        ],
      ),
    );
  }
}
