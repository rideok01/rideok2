import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rideok2/informationhandler/app_info.dart';
import 'package:rideok2/models/directions.dart';
import 'package:rideok2/models/directions_detail.dart';
import 'package:rideok2/models/directions_new.dart';
import 'package:rideok2/models/user_model.dart';
import 'package:rideok2/request_assistant.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/map_key.dart';

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoOrdinates(
      Position position, context) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";
    String humanReadableAddress = "";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if (requestResponse != "Error Occurred, Failed. No Response.") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }

    return humanReadableAddress;
  }

  static void readCurrentOnlineUserInfo() async {
    currentFirebaseUser = fAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<DirectionDetailsInfo?>
      obtainOriginToDestinationDirectionDetails(
          LatLng origionPosition, LatLng destinationPosition) async {
    String urlOriginToDestinationDirectionDetails =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origionPosition.latitude},${origionPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapkey";

    var responseDirectionApi = await RequestAssistant.receiveRequest(
        urlOriginToDestinationDirectionDetails);

    if (responseDirectionApi == "Error Occurred, Failed. No Response.") {
      return null;
    }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points =
        responseDirectionApi["routes"][0]["overview_polyline"]["points"];

    directionDetailsInfo.distance_text =
        responseDirectionApi["routes"][0]["legs"][0]["distance"]["text"];
    directionDetailsInfo.distance_value =
        responseDirectionApi["routes"][0]["legs"][0]["distance"]["value"];

    directionDetailsInfo.duration_text =
        responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];
    directionDetailsInfo.duration_value =
        responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetailsInfo;
  }

  static Future<Directions_New?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    var dio = Dio();
    String url2 = 'https://maps.googleapis.com/maps/api/directions/json?';
    final response = await dio.get(url2, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': mapkey,
    });
    if (response.statusCode == 200) {
      return Directions_New.fromMap(response.data);
    } else {
      return null;
    }
  }

  static Future<List> addLocations(LatLng pickUp, LatLng drop) async {
    List drivers = [];
    List userPoints = [];
    List availableDrivers = [];
    Directions_New? points;

    DatabaseReference testref = FirebaseDatabase.instance
        .ref()
        .child('Amity University Noida')
        .child('rides');

    await testref.once().then((value) {
      Map? b = value.snapshot.value as Map?;
      b!.forEach((index, data) => drivers.add({'key': index, ...data}));
    });

    points =
        await AssistantMethods.getDirections(origin: pickUp, destination: drop);

    userPoints = points!.polylinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();

    /// i is for looping through userPoints
    /// j is for looping through all the drivers going to Amity
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < drivers.length; j++) {
        if (Geolocator.distanceBetween(
                    userPoints[userPoints.length * i ~/ 10].latitude,
                    userPoints[0].longitude,
                    drivers[j]['start_lat'],
                    drivers[j]['start_lng']) <
                50000 ||
            Geolocator.distanceBetween(
                    userPoints[userPoints.length * i ~/ 10].latitude,
                    userPoints[0].longitude,
                    drivers[j]['mid_lat'],
                    drivers[j]['mid_long']) <
                50000 ||
            Geolocator.distanceBetween(
                    userPoints[userPoints.length * i ~/ 10].latitude,
                    userPoints[0].longitude,
                    drivers[j]['end_lat'],
                    drivers[j]['end_lng']) <
                50000) {
          print('Drivers are available');
          availableDrivers.add(drivers[j]['key']);
        } else {
          print('Drivers are not available');
        }
      }
    }
    availableDrivers = availableDrivers.toSet().toList();
    print(availableDrivers);
    return availableDrivers;
  }
}
