// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:rideok2/assistant_methods.dart';
import 'package:rideok2/informationhandler/app_info.dart';
import 'package:rideok2/models/destination_points.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/driver/driver_home.dart';
import 'package:rideok2/screens/search_screens/search_places.dart';
import 'package:rideok2/screens/search_screens2/search_places2.dart';
import 'package:rideok2/screens/tabs/homebutton1.dart';
import 'package:rideok2/screens/tabs/homebutton2.dart';
import 'package:rideok2/screens/tabs/homebutton3.dart';
import 'package:rideok2/screens/tabs/map.dart';
import 'package:rideok2/screens/user_navigation.dart';
import 'package:velocity_x/velocity_x.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isPressed = false;

  LocationPermission? _locationPermission;
  Position? userCurrentPosition;
  var geoLocator = Geolocator();

  List availableDrivers = [];
  late LatLng pickUp;
  late LatLng drop;
  bool _isLoading = false;

  DetailsResult? startPosition;
  DetailsResult? endPosition;
  String? dropDownValue;
  final DestinationPoints location1 = DestinationPoints(
      'Amity University Noida', 28.54412733486746, 77.33307631780283);
  final DestinationPoints location2 = DestinationPoints(
      'HCL Office Indirapuram', 28.608585486138754, 77.36293993959215);

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  Future<List> availableDriverFunc() async {
    _isLoading = true;
    setState(() {});

    List list = [];
    pickUp = LatLng(
        Provider.of<AppInfo>(context, listen: false)
            .userPickUpLocation!
            .locationLatitude!,
        Provider.of<AppInfo>(context, listen: false)
            .userPickUpLocation!
            .locationLongitude!);

    switch (dropDownValue) {
      case 'Amity University Noida':
        drop = LatLng(location1.lat, location1.lng);
        break;
      case 'HCL Office Indirapuram':
        drop = LatLng(location2.lat, location2.lng);
        break;
      default:
        drop = LatLng(location1.lat, location1.lng);
        break;
    }

    list = await AssistantMethods.addLocations(pickUp, drop);
    _isLoading = false;
    setState(() {});
    return list;
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
    Offset distance = isPressed ? const Offset(10, 10) : const Offset(5, 5);
    double blur = isPressed ? 5.0 : 10.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(153, 255, 255, 255),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 07),
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
          const Positioned(
              left: 17,
              top: 65,
              width: 145,
              height: 176,
              child: Text(
                'Car Pool  ' 'With            ' 'the Knowns',
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
              child: FittedBox(
                child: Container(
                  width: 350,
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                    gradient: LinearGradient(
                        begin:
                            Alignment(0.9797160029411316, 0.03849898651242256),
                        end: Alignment(
                            -0.03849898651242256, 0.04261964559555054),
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
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => SearchPlaces2()));
                            }),
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
                                      "From",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      Provider.of<AppInfo>(context)
                                                  .userPickUpLocation !=
                                              null
                                          ? (Provider.of<AppInfo>(context)
                                              .userPickUpLocation!
                                              .locationName!)
                                          : "your current address",
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

                          //to destination
                          DropdownButton(
                              isExpanded: true,
                              value: dropDownValue,
                              items: [location1.name, location2.name]
                                  .map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value).pOnly(left: 8, right: 8),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });
                              }),

                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),

                          const SizedBox(height: 10.0),

                          ElevatedButton(
                            onPressed: () async {
                              if (dropDownValue == null) {
                                Fluttertoast.showToast(
                                    msg: 'Please select a Location');
                              } else {
                                availableDrivers.clear();
                                availableDrivers = await availableDriverFunc();
                                
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 146, 182, 244),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text(
                              "Request a Ride",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          Positioned(
              top: 433,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeButton1(),
                      const SizedBox(
                        width: 22,
                      ),
                      HomeButton2(),
                      const SizedBox(
                        width: 22,
                      ),
                      HomeButton3(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: availableDrivers.isEmpty 
                    ? _isLoading 
                      ? const Center(child: CircularProgressIndicator()) 
                      : const Center(child: Text('Search For Drivers')) 
                    : ListView.builder(
                      shrinkWrap: true,
                      itemCount: availableDrivers.length,
                      itemBuilder: (context, index) {
                          return Container(
                            color: Colors.green,
                            child: ListTile(
                              title: Text(availableDrivers[index].toString()),
                            ),
                          );
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
