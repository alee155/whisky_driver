import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import '../../Utils/AppImage/app_images.dart';
import '../Account/account.dart';
import '../Earnings/earnings.dart';
import '../Inbox/inbox.dart';

import '../SplashScreen/splash_screen.dart';
import '../feedback/feed_back.dart';

class bottomW extends StatefulWidget {
  const bottomW({super.key});

  @override
  State<bottomW> createState() => _bottomWState();
}

class _bottomWState extends State<bottomW> {
  int current = 0;
  final tabs = [
    splash_screen(),
    Earnings(),
    feed_back(),
    inbox(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 6, // Spread radius
              blurRadius: 9, // Blur radius
              offset: Offset(0, 3), // Offset
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red, // Selected icon color
          unselectedItemColor: Colors.grey, // Unselected icon color
          currentIndex: current,
          onTap: (index) {
            setState(() {
              current = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImage.bag,
                color: current == 0
                    ? Colors.red
                    : Colors.grey, // Set color based on selected index
              ),
              label: "", // Empty label
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImage.dollar,
                color: current == 1
                    ? Colors.red
                    : Colors.grey, // Set color based on selected index
              ),
              label: "", // Empty label
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImage.signal,
                color: current == 2
                    ? Colors.red
                    : Colors.grey, // Set color based on selected index
              ),
              label: "", // Empty label
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImage.message,
                color: current == 3
                    ? Colors.red
                    : Colors.grey, // Set color based on selected index
              ),
              label: "", // Empty label
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImage.user,
                color: current == 4
                    ? Colors.red
                    : Colors.grey, // Set color based on selected index
              ),
              label: "", // Empty label
            ),
          ],
        ),
      ),
      body: tabs[current],
    );
  }
}
