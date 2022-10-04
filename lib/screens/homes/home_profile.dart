import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.arrow_back, size: 35,),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.asset("assets/logos.png"),
            const Text(
              "Manage Home Profile"
            )
          ],
        ),
      ),
    );
  }
}
