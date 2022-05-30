import 'package:flutter/material.dart';

class Earnings extends StatefulWidget {
  Earnings({Key? key}) : super(key: key);

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "Earnings"
      ),
    );
  }
}