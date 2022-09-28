import 'package:em_home/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomMessageScreen extends StatefulWidget {
  const CustomMessageScreen({Key? key}) : super(key: key);

  @override
  State<CustomMessageScreen> createState() => _CustomMessageScreenState();
}

class _CustomMessageScreenState extends State<CustomMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor2,
      ),
      endDrawer: const NavigationDrawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              'assets/logos.png',
            ),
            GestureDetector(
              child: Container(
                width: double.infinity,
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: buttonColor2,
                ),
                child: const Text(
                  "Please Keep the Noise Down",
                  style: TextStyle(
                      color: buttonTextColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
