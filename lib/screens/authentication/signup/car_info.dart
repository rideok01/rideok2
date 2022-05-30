import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/driver/driver_splash.dart';
import 'package:rideok2/screens/splash_screen.dart';


class CarInfo extends StatefulWidget {

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {

  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = ["uber-x", "uber-go", "bike"];
String? selectedCarType;

saveCarInfo()
  {
    Map CarInfoMap =
    {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(CarInfoMap);

    Fluttertoast.showToast(msg: "Car Details has been saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> DriverSplash()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(42.0),
      child: Container(
        child: Stack(
            children: [
               Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              Positioned( 
                left: 107,
                top: 155,
                right: null,
                bottom: null,
                width: 176,
                height: 176,
                child: Image.asset('assets/images/logo.png'),),
              Positioned( 
                left: -274,
                top: 709,
                right: null,
                bottom: null,
                width: 442,
                height: 442,
                child: SvgPicture.asset('assets/images/ellipse.svg'),),
              Positioned( 
                left: 222,
                top: -292,
                right: null,
                bottom: null,
                width: 442,
                height: 442,
            
                child: SvgPicture.asset('assets/images/ellipse.svg'),
                ),
              Positioned(
                left: 150.0,
                top: 341.0,
                right: null,
                bottom: null,
                width: 96.0,
                height: 36.0,
                child: Text(
                      '''RideOK''',
                     overflow: TextOverflow.visible,
                       textAlign: TextAlign.left,
                    style: TextStyle(
                      height: 1.171875,
                        fontSize: 26.0,
                       fontFamily: 'Inter',
                       fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 104, 149, 251),

                        ),
                      ),
              ),
              Positioned(
                left: 130.0,
                top: 391.0,
                right: null,
                bottom: null,
                width: 200.0,
                height: 36.0,
                child: Text(
                   '''Car Details''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                  style: TextStyle(
                     height: 1.171875,
                     fontSize: 26.0,
                     fontFamily: 'Inter',
                     fontWeight: FontWeight.w400,
                     color: Color.fromARGB(255, 104, 149, 251),

                           ),
                       ),
              ),
              Positioned(
                left: 85.0,
                top: 447.0,
                right: null,
                bottom: null,
                width: 226.0,
                height: 24.0,
                child: TextField(
                     controller: carModelTextEditingController,
                    style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    hintText: "Car Model",
                       enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.grey),
                     ),
                        focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                          ),
                       hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                              ),
                              ),
                           ),
              ),
              Positioned(
                left: 85.0,
                top: 501.0,
                right: null,
                bottom: null,
                width: 226.0,
                height: 21.0,
                child: TextField(
                        controller: carNumberTextEditingController,
                           style: const TextStyle(color: Colors.grey),
                         decoration: const InputDecoration(
                             hintText: "Car Number",
                           enabledBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.grey),
                        ),
                           focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                      ),
                       hintStyle: TextStyle(
                           color: Colors.grey,
                         fontSize: 16,
                          ),
                          ),
                          ),
              ),
              Positioned(
                left: 85.0,
                top: 555.0,
                right: null,
                bottom: null,
                width: 226.0,
                height: 24.0,
                child: TextField(
                  controller: carColorTextEditingController,
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      hintText: "Car Color",
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                        focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                         ),
                       hintStyle: TextStyle(
                       color: Colors.grey,
                      fontSize: 16,
                          ),
                         ),
                     ),
              ),
               Positioned(
                left: 85.0,
                top: 611.0,
                right: null,
                bottom: null,
                width: 226.0,
                height: 24.0,
                child: DropdownButton(
                                iconSize: 26,
                          dropdownColor: Color.fromARGB(255, 255, 252, 252),
                               hint:  Text(
                           "Please choose Car Type",
                            style: TextStyle(
                              overflow: TextOverflow.visible,
                                fontSize: 16.0,
          
                             color: Colors.grey,
                           ),
        
                         ),
                        value: selectedCarType,
                     onChanged: (newValue) {
                      setState(() {
                        selectedCarType = newValue.toString();
                        });
                 },
                     items: carTypesList.map((car) {
                        return DropdownMenuItem(
                       child: Text(
                          car,
                        style: const TextStyle(color: Colors.grey),
                        ),
                     value: car,
                     );
                  }).toList(),
      
                      ),
              ),
              Positioned(
                left: 62.0,
                top: 665.0,
                right: null,
                bottom: null,
                width: 266.0,
                height: 51.0,
                child: GestureDetector(
      onTap: () => {
                      if(carColorTextEditingController.text.isNotEmpty
                      && carNumberTextEditingController.text.isNotEmpty
                      && carModelTextEditingController.text.isNotEmpty && selectedCarType != null)
                  {
                    saveCarInfo(),
                  },},
      child: Container(
        width: 266.0,
        height: 51.0,
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0.0,
                top: 0.0,
                right: null,
                bottom: null,
                width: 266.0,
                height: 51.0,
                child: Container(
                 width: 266.0,
                height: 51.0,
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33.0),
                  ),
                     child: ClipRRect(
                     borderRadius: BorderRadius.circular(33.0),
                       child: Container(
                         color: Color.fromARGB(255, 104, 149, 251),
                    ),
                    ),
                      ),
              ),
              Positioned(
                left: 90.0000228881836,
                top: 11.0,
                right: null,
                bottom: null,
                width: 92.00000762939453,
                height: 34.0,
                child: Text(
                   '''Next''',
                     overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                     style: TextStyle(
                       height: 1.171875,
                        fontSize: 24.0,
                       fontFamily: 'Inter',
                       fontWeight: FontWeight.w500,
                       color: Color.fromARGB(255, 255, 255, 255),

                          ),
                        ),
              )
            ]),
      ),
    ),
              ),
            ]),
      ),
    );
  }
}