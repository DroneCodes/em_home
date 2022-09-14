import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  String photoUrl;
  String homeName;
  String message;

  HomeMenu({
    Key? key,
    required this.photoUrl,
    required this.homeName,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(),
    );
  }
}
