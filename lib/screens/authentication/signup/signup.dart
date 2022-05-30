import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/authentication/login/login_screen.dart';
import 'package:rideok2/screens/authentication/process_dialog.dart';
import 'package:rideok2/screens/authentication/signup/car_info.dart';
import 'package:rideok2/screens/splash_check.dart';
import 'package:rideok2/screens/splash_screen.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be atleast 3 Characters.");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be atleast 6 Characters.");
    } else {
      saveuserinfo();
    }
  }
  saveuserinfo() async
  {
    showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext c) {
            return ProcessDialog(
              message: "Processing, Please wait...",
            );
          });
          
          final User? firebaseUser = (
      await fAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      ).catchError((msg){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: " + msg.toString());
      })
    ).user;

    if(firebaseUser != null)
    {
      Map usersMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("users");
      driversRef.child(firebaseUser.uid).set(usersMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashCheck()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
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
              child: Image.asset('assets/images/logo.png'),
            ),
            Positioned(
              left: -274,
              top: 709,
              right: null,
              bottom: null,
              width: 442,
              height: 442,
              child: SvgPicture.asset('assets/images/ellipse.svg'),
            ),
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
              left: 130.0,
              top: 391.0,
              right: null,
              bottom: null,
              width: 200.0,
              height: 36.0,
              child: Text(
                '''Registration''',
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
                controller: nameTextEditingController,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  hintText: "Name",
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
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  hintText: "Email",
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
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  hintText: "Phone",
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
              child: TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  hintText: "Password",
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
              left: 62.0,
              top: 665.0,
              right: null,
              bottom: null,
              width: 266.0,
              height: 51.0,
              child: GestureDetector(
                onTap: () => validateForm(),
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
            Positioned(
              left: 62.0,
              top: 714.0,
              right: null,
              bottom: null,
              width: 266.0,
              height: 51.0,
              child: TextButton(
                child: const Text(
                  "Already have an account? Login Here",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => LoginScreen()));
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
