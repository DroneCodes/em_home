import 'package:em_home/drawer/navigation_drawer.dart';
import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class SetStatusScreen extends StatefulWidget {
  const SetStatusScreen({Key? key}) : super(key: key);

  @override
  State<SetStatusScreen> createState() => _SetStatusScreenState();
}

class _SetStatusScreenState extends State<SetStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      endDrawer: const NavigationDrawer(),
      body: Container(
        color: backgroundColor2,
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Image.asset(
                'assets/logos.png',
            ),

            const SizedBox(
              height: 25,
            ),

            Container(
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                color: buttonColor2,
              ),
              child: const Text(
                "At Home",
                style: TextStyle(
                    color: buttonTextColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                color: buttonColor2,
              ),
              child: const Text(
                "Away",
                style: TextStyle(
                    color: buttonTextColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
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
                "Sleeping",
                style: TextStyle(
                    color: buttonTextColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
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
                "Studying",
                style: TextStyle(
                    color: buttonTextColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              child: const Text(
                "Set Custom Status",
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
