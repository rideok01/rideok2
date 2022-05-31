// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:rideok2/assistant_methods.dart';
import 'package:rideok2/informationhandler/app_info.dart';
import 'package:rideok2/models/destination_points.dart';
import 'package:rideok2/models/directions.dart';
import 'package:rideok2/models/directions_detail.dart';
import 'package:rideok2/models/directions_new.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/map_key.dart';
import 'package:rideok2/screens/navigation_sidebar.dart';
import 'package:rideok2/screens/search_screens/search_places.dart';
import 'package:rideok2/screens/search_screens2/search_places2.dart';
import 'package:rideok2/screens/tabs/driverswitch.dart';
import 'package:rideok2/screens/tabs/homebutton1.dart';
import 'package:velocity_x/velocity_x.dart';

class OfferRide extends StatefulWidget {
  @override
  State<OfferRide> createState() => _OfferRideState();
}

class _OfferRideState extends State<OfferRide> {
  GoogleMapController? _googleMapController;
  Directions_New? _info;
  Set<Polyline> polyLineSet = {};
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GooglePlace googlePlace;
  final urlImage =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  final _startingLocationController = TextEditingController();
  final _endingLocationController = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  LatLng? endPoint;

  String? dropDownValue;
  final DestinationPoints location1 = DestinationPoints(
      'Amity University Noida', 28.54412733486746, 77.33307631780283);
  final DestinationPoints location2 = DestinationPoints(
      'HCL Office Noida', 28.537556070138418, 77.34292653194981);

  Marker? _origin;
  Marker? _destination;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  Map? locationInfo;

  List<AutocompletePrediction> predictions = [];
  Timer? debounce;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.6483451, 77.3797245),
    zoom: 14.4746,
  );

  drawPolyLine2(DetailsResult a, LatLng b) async {
    setState(() {
      _origin = Marker(
          markerId: const MarkerId('start'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position:
              LatLng(a.geometry!.location!.lat!, a.geometry!.location!.lng!));

      _destination = Marker(
          markerId: const MarkerId('end'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: b);
    });

    _info = (await AssistantMethods.getDirections(
        origin: LatLng(a.geometry!.location!.lat!, a.geometry!.location!.lng!),
        destination: b))!;

    setState(() {
      print("New Info" + _info!.polylinePoints.toString());
    });
  }

  drawPolyLine(DetailsResult a, DetailsResult b) async {
    print('Location are : ' +
        b.geometry!.location!.lat!.toString() +
        ' : ' +
        b.geometry!.location!.lng!.toString());

    setState(() {
      _origin = Marker(
          markerId: const MarkerId('start'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position:
              LatLng(a.geometry!.location!.lat!, a.geometry!.location!.lng!));
      _destination = Marker(
          markerId: const MarkerId('end'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position:
              LatLng(b.geometry!.location!.lat!, b.geometry!.location!.lng!));
    });

    _info = (await AssistantMethods.getDirections(
        origin: LatLng(a.geometry!.location!.lat!, a.geometry!.location!.lng!),
        destination:
            LatLng(b.geometry!.location!.lat!, b.geometry!.location!.lng!)))!;

    setState(() {
      print("New Info" + _info!.polylinePoints.toString());
    });
  }

  blackThemeGoogleMap() {
    _googleMapController!.setMapStyle(mapStyle);
  }

  @override
  void initState() {
    super.initState();
    String apiKey = mapkey;
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
    _googleMapController!.dispose();
  }

  autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      debugPrint(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: false,
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          markers: {
            if (_origin != null) _origin!,
            if (_destination != null) _destination!
          },
          initialCameraPosition: _kGooglePlex,
          polylines: {
            if (_info != null)
              Polyline(
                polylineId: const PolylineId('Polyline'),
                color: Colors.red,
                width: 3,
                points: _info!.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              )
          },
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            _googleMapController = controller;

            //for black theme google map
            blackThemeGoogleMap();
            //locateUserPosition();
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ButtonStyle(
                enableFeedback: true,
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  return states.contains(MaterialState.pressed)
                      ? Colors.grey
                      : null;
                }),
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            child: const Text(
              'Confrim Ride',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              if (_info != null) {
                print("PolyLine set is : " + _info!.polylinePoints.toString());
                if (dropDownValue == 'Amity University Noida') {
                  locationInfo = {
                    "userId": currentFirebaseUser!.uid,
                    "start_location": startPosition!.name,
                    "start_lat": startPosition!.geometry!.location!.lat,
                    "start_lng": startPosition!.geometry!.location!.lng,
                    "end_location": 'Amity University Noida',
                    "end_lat": location1.lat,
                    "end_lng": location1.lng
                  };
                } else {
                  locationInfo = {
                    "userId": currentFirebaseUser!.uid,
                    "start_location": startPosition!.name,
                    "start_lat": startPosition!.geometry!.location!.lat,
                    "start_lng": startPosition!.geometry!.location!.lng,
                    "end_location": 'HCL Office Noida',
                    "end_lat": location2.lat,
                    "end_lng": location2.lng
                  };
                }

                print('User is : ' + currentFirebaseUser!.uid.toString());

                DatabaseReference locationref =
                    FirebaseDatabase.instance.ref().child(dropDownValue!);
                await locationref.child('rides').child(currentFirebaseUser!.uid).set(locationInfo);

                setState(() {
                  Fluttertoast.showToast(msg: "Your Ride has been added.");
                });
              } else {
                Fluttertoast.showToast(msg: "Please enter Start and Dropoff location");
              }
            },
          ).pOnly(bottom: 20),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              TextField(
                controller: _startingLocationController,
                focusNode: startFocusNode,
                decoration: InputDecoration(
                    suffixIcon: _startingLocationController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                predictions = [];
                                _startingLocationController.clear();
                              });
                            },
                            icon: const Icon(Icons.clear_outlined))
                        : null,
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(CupertinoIcons.location_solid),
                    hintText: 'Starting Location'),
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce!.cancel();
                  debounce = Timer(const Duration(microseconds: 800), () {
                    if (value.isNotEmpty) {
                      autoCompleteSearch(value);
                    } else {
                      //clear the search
                      setState(() {
                        predictions = [];
                        startPosition = null;
                      });
                    }
                  });
                },
              ).pOnly(left: 12, right: 12, top: 12),
              // TextField(
              //   controller: _endingLocationController,
              //   focusNode: endFocusNode,
              //   enabled: _startingLocationController.text.isNotEmpty &&
              //       startPosition != null,
              //   decoration: InputDecoration(
              //       suffixIcon: _endingLocationController.text.isNotEmpty
              //           ? IconButton(
              //               onPressed: () {
              //                 setState(() {
              //                   predictions = [];
              //                   _endingLocationController.clear();
              //                 });
              //               },
              //               icon: const Icon(Icons.clear_outlined))
              //           : null,
              //       fillColor: Colors.white,
              //       filled: true,
              //       prefixIcon: const Icon(CupertinoIcons.location_solid),
              //       hintText: 'Ending Location'),
              //   onChanged: (value) {
              //     if (debounce?.isActive ?? false) debounce!.cancel();
              //     debounce = Timer(const Duration(microseconds: 800), () {
              //       if (value.isNotEmpty) {
              //         autoCompleteSearch(value);
              //       } else {
              //         //clear the search
              //         setState(() {
              //           predictions = [];
              //           startPosition = null;
              //         });
              //       }
              //     });
              //   },
              // ).pOnly(left: 12, right: 12, top: 12),
              Container(
                color: Colors.white,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isExpanded: true,
                      value: dropDownValue,
                      items:
                          [location1.name, location2.name].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value).pOnly(left: 8, right: 8),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                          if (startPosition != null && dropDownValue != null) {
                            debugPrint('Adding Markers via dropdown');
                            switch (dropDownValue) {
                              case 'Amity University Noida':
                                endPoint = LatLng(location1.lat, location1.lng);
                                break;
                              case 'HCL Office Noida':
                                endPoint = LatLng(location2.lat, location2.lng);
                                break;
                              default:
                                endPoint = LatLng(location1.lat, location1.lng);
                                break;
                            }

                            drawPolyLine2(startPosition!, endPoint!);
                          }
                        });
                      }).pOnly(left: 4, right: 4),
                ),
              ).pOnly(left: 12, right: 12, top: 12),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.pin_drop),
                        ),
                        isThreeLine: false,
                        title: Text(
                          predictions[index].description.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      onPressed: () async {
                        final placeId = predictions[index].placeId!;
                        final details = await googlePlace.details.get(placeId);

                        if (details != null &&
                            details.result != null &&
                            mounted) {
                          if (startFocusNode.hasFocus) {
                            setState(() {
                              startPosition = details.result;
                              _startingLocationController.text =
                                  details.result!.name!.toString();
                              predictions = [];
                              debugPrint(
                                  'Name of Location is : ${_startingLocationController.text}');
                              debugPrint('location is : $startPosition');
                            });
                          } else {
                            setState(() {
                              endPosition = details.result;
                              _endingLocationController.text =
                                  details.result!.name!.toString();
                              predictions = [];
                            });

                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        }

                        if (startPosition != null && endPosition != null) {
                          debugPrint('Adding Markers');
                          drawPolyLine(startPosition!, endPosition!);
                        }
                      },
                    ).p(2);
                  }).p(12),
            ],
          ),
        )
      ]),
    ));
  }
}
