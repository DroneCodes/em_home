import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/drawer/navigation_drawer.dart';
import 'package:em_home/screens/set_status.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/widgets/member_status.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      endDrawer: const NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: backgroundColor2,
      ),
        body: Container(
          padding: const EdgeInsets.only(left: 25, top: 100, right: 25),
          child: Column(
            children: [
              Image.asset(
                'assets/logos.png',
              ),
              const SizedBox(
                height: 25,
              ),
              // StreamBuilder(
              //     stream:
              //         FirebaseFirestore.instance.collection("users").snapshots(),
              //     builder: (context,
              //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
              //             snapshot) {
              //       return ListView.builder(
              //           itemBuilder: (context, index) => const MemberStatus());
              //     }),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SetStatusScreen()));
                },
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
                    "Set Status",
                    style: TextStyle(
                        color: buttonTextColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                    "Text HouseMates",
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
