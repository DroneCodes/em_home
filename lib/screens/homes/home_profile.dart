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
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: const [
                SizedBox(
                  width: 25,
                  child: Text(
                    "Home Name",
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 160,
                  child: Text("Home Name"),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: const [
                SizedBox(
                  width: 25,
                  child: Text(
                    "Address",
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 160,
                  child: Text("Address"),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: const [
                SizedBox(
                  width: 25,
                  child: Text(
                    "City",
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 160,
                  child: Text("City"),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                Row(
                  children: const [
                    SizedBox(
                      width: 25,
                      child: Text(
                        "State",
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 75,
                      child: Text("State"),
                    ),
                  ],
                ),

                const SizedBox(
                  width: 20,
                ),

                Row(
                  children: const [
                    SizedBox(
                      width: 15,
                      child: Text(
                        "ZIP",
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 60,
                      child: Text("ZIp"),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 40,
            ),

            Container(
              width: double.infinity,
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                color: buttonColor,
              ),
              child: const Text(
                "Add Member",
                style: TextStyle(
                    color: buttonTextColor,
                    fontWeight: FontWeight.bold),
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
                color: buttonColor,
              ),
              child: const Text(
                "Leave Home",
                style: TextStyle(
                    color: buttonTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
