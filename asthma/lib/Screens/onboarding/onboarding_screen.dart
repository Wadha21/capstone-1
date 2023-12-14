import 'package:asthma/Screens/onboarding/boarding_bottomsheet.dart';
import 'package:asthma/Screens/onboarding/onboarding_pages.dart/onboarding_1.dart';
import 'package:asthma/Screens/onboarding/onboarding_pages.dart/onboarding_3.dart';
import 'package:asthma/Screens/onboarding/onboarding_pages.dart/onboarding_4.dart';
import 'package:asthma/Screens/onboarding/onboarding_pages.dart/onboarding_2.dart';
import 'package:asthma/helper/imports.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class OnboradingScreen extends StatefulWidget {
  const OnboradingScreen({super.key});

  @override
  State<OnboradingScreen> createState() => _OnboradingScreenState();
}

late PageController controller;
int pageIndex = 0;

class _OnboradingScreenState extends State<OnboradingScreen> {
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    // _determinePosition();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (value) {
         
            setState(() {
              pageIndex = value;
            });
          },
          children: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Page1(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Page2(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Page3(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Page4(),
            ),
          ],
        ),
      ),
      bottomSheet: BoardingBottomsheet(
        pageController: controller,
      ),
    );
  }
}


Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
     
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
   
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}
