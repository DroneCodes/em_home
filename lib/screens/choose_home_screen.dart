import 'package:em_home/screens/create_home.dart';
import 'package:em_home/screens/join_home.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:flutter/material.dart';

class ChooseHomeScreen extends StatelessWidget {
  const ChooseHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 300, left: 30, right: 30),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, CustomRoute(widget: JoinHomeScreen()));
                },
                child: Container(
                    width: double.infinity,
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                      color: buttonColor,
                    ),
                    child: const Text(
                      "Join existing Home",
                      style: TextStyle(
                          color: buttonTextColor, fontWeight: FontWeight.bold),
                    ),),
              ),

              const SizedBox(
                height: 25,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, SlideLeftRoute(widget: const CreateHomeScreen()));
                },
                child: Container(
                  width: double.infinity,
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    color: buttonColor,
                  ),
                  child: const Text(
                    "Create new Home",
                    style: TextStyle(
                        color: buttonTextColor, fontWeight: FontWeight.bold),
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
