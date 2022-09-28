import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String name;
  final Function() onPress;
  const DrawerItem({Key? key, required this.name, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child:  Container(
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
