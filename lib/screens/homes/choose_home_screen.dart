
import 'package:em_home/screens/users/user_profile.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/model.dart';
import '../../providers/user_provider.dart';
import 'create_home.dart';

class ChooseHomeScreen extends StatefulWidget {
  const ChooseHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChooseHomeScreen> createState() => _ChooseHomeScreenState();
}

class _ChooseHomeScreenState extends State<ChooseHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 300, left: 30, right: 30),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, CustomRoute(widget: UserProfileScreen(uid: user.uid)));
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
                  Navigator.push(context, SlideLeftRoute(widget: const CreateHomeScreen()));
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
