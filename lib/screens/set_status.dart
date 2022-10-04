import 'package:em_home/drawer/navigation_drawer.dart';
import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class SetStatusScreen extends StatefulWidget {
  const SetStatusScreen({Key? key}) : super(key: key);

  @override
  State<SetStatusScreen> createState() => _SetStatusScreenState();
}

class _SetStatusScreenState extends State<SetStatusScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavigationDrawer(),
      key: scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.4, 1.2,],
              colors: [Color(0xFFE0F880), Colors.white,],
              tileMode: TileMode.repeated),
        ),
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: Colors.black,
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 40,
                      color: Colors.black,
                    ),
                    onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
                color: buttonColor,
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
                color: buttonColor,
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
                color: buttonColor,
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
                color: buttonColor,
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
              onTap: () {

              },
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
