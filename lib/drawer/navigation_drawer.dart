import 'package:em_home/drawer/drawer_item.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: backgroundColor2,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            header(),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              thickness: 1,
              height: 5,
              color: buttonColor2,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
              name: "My Profile",
              onPress: () => onItemPressed(context, page: 0
              ),
            ),
            const Divider(
              thickness: 1,
              height: 5,
              color: buttonColor2,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
              name: "Rename Home",
              onPress: () => onItemPressed(context, page: 1
              ),
            ),
            const Divider(
              thickness: 1,
              height: 5,
              color: buttonColor2,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
              name: "Add Member",
              onPress: () => onItemPressed(context, page: 2
              ),
            ),
            const Divider(
              thickness: 1,
              height: 5,
              color: buttonColor2,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
              name: "House Rules",
              onPress: () => onItemPressed(context, page: 3
              ),
            ),
            const Divider(
              thickness: 1,
              height: 5,
              color: buttonColor2,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
              name: "Leave Home",
              onPress: () => onItemPressed(context, page: 4
              ),
            ),
            const Divider(
              thickness: 1,
              height: 5,
              color: buttonColor2,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
              name: "Log Out",
              onPress: () => onItemPressed(context, page: 5
              ),
            ),
            const Divider(
              thickness: 1,
              height: 5,
              color: buttonColor2,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
              name: "Contact Us",
              onPress: () => onItemPressed(context, page: 6
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        "Menu",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int page}) {
    Navigator.pop(context);

    switch (page) {

    }
  }
}
