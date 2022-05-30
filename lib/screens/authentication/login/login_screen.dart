import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rideok2/screens/authentication/global.dart';
import 'package:rideok2/screens/authentication/process_dialog.dart';
import 'package:rideok2/screens/authentication/signup/signup.dart';
import 'package:rideok2/screens/main_screen.dart';
import 'package:rideok2/screens/splash_check.dart';
import 'package:rideok2/screens/splash_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required.");
    } else {
      loginuserNow();
    }
  }

  loginuserNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProcessDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successful.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashCheck()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }
//asd
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(42.0),
      child: Container(
        child: Stack(children: [
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
            left: 160.0,
            top: 391.0,
            right: null,
            bottom: null,
            width: 200.0,
            height: 36.0,
            child: Text(
              '''Login''',
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
            top: 501.0,
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
            top: 555.0,
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
                          '''Login''',
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
            top: 609.0,
            right: null,
            bottom: null,
            width: 266.0,
            height: 51.0,
            child: TextButton(
              child: const Text(
                "Do not have an account? Register Here",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SignUp()));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
