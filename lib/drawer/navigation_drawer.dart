import 'package:em_home/drawer/drawer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xFFE0F880),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Icon(CupertinoIcons.multiply, size: 30,),
            ),
            const SizedBox(
              height: 15,
            ),
            header(),
            const SizedBox(
              height: 25,
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Text("Manage", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            ),
            const SizedBox(
              height: 10,
            ),

            const Divider(
              thickness: 1,
              color: Color(0xFF5AA74D),
            ),

            const SizedBox(
              height: 10,
            ),

            DrawerItem(
              name: "My Profile",
              onPress: () => onItemPressed(context, page: 0),
            ),

            const SizedBox(
              height: 15,
            ),

            DrawerItem(
              name: "Manage Home",
              onPress: () => onItemPressed(context, page: 1),
            ),

            const SizedBox(
              height: 15,
            ),
            DrawerItem(
              name: "Log Out",
              onPress: () => onItemPressed(context, page: 2),
            ),

            const SizedBox(
              height: 15,
            ),

            const Divider(
              thickness: 1,
              color: Color(0xFF5AA74D),
            ),

            const SizedBox(
              height: 15,
            ),

            DrawerItem(
              name: "About",
              onPress: () => onItemPressed(context, page: 3),
            ),

            const SizedBox(
              height: 15,
            ),

            DrawerItem(
              name: "Share App",
              onPress: () => onItemPressed(context, page: 4),
            ),

            const SizedBox(
              height: 15,
            ),

            DrawerItem(
              name: "Contact Us",
              onPress: () => onItemPressed(context, page: 5),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset("assets/logos.png"),
          const Text(
            "EM Home",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int page}) {
    Navigator.pop(context);

    switch (page) {
    }
  }
}
