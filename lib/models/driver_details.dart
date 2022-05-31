// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverDetails {
  final int uid;
  final LatLng start;
  final LatLng end;
  DriverDetails({
    required this.uid,
    required this.start,
    required this.end,
  });
}
