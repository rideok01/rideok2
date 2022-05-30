import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:rideok2/screens/driver/driver_splash.dart';
import 'package:rideok2/screens/main_screen.dart';
import 'package:rideok2/screens/tabs/map.dart';
import 'package:rideok2/screens/tabs/profile.dart';
import 'package:rideok2/screens/tabs/ratings.dart';

class UserNavigation extends StatelessWidget {
  String? namee;
  String? emaill;

  UserNavigation({this.namee, this.emaill});

  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = namee.toString();
    final email = emaill.toString();
    const urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Profile(),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const Divider(color: Colors.black),
                  buildMenuItem(
                    text: 'Your Rides',
                    icon: Icons.car_rental,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  buildMenuItem(
                    text: 'Token Wallet',
                    icon: Icons.wallet_rounded,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  buildMenuItem(
                    text: 'Coupons',
                    icon: Icons.collections_bookmark,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  buildMenuItem(
                    text: 'History',
                    icon: Icons.history,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  buildMenuItem(
                    text: 'Payments',
                    icon: Icons.money,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  buildMenuItem(
                    text: 'Past Passengers',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const Divider(color: Colors.black),
                  buildMenuItem(
                    text: 'About',
                    icon: Icons.note,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.center,
                    child: Text('Follow us on'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: (() {}),
                        icon: const FaIcon(FontAwesomeIcons.twitter),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: (() {}),
                        icon: const FaIcon(FontAwesomeIcons.instagram),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: (() {}),
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 120,
                    child: Text(
                      email,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: const Color.fromRGBO(30, 60, 168, 1),
                child:
                    const Icon(Icons.add_comment_outlined, color: Colors.black),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    const hoverColor = Colors.black;

    return Row(
      children: [
        Icon(icon, color: color, size: 24).p(8),
        const SizedBox(width: 10),
        Text(text).p(8),
      ],
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MapPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Profile(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DriverSplash(),
        ));
        break;
    }
  }
}
