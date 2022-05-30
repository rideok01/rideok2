import 'package:flutter/material.dart';

class DriverScreen extends StatefulWidget {
  DriverScreen({Key? key}) : super(key: key);

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "Driver Home"
      ),
    );
  }
}