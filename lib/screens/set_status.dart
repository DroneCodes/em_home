import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class SetStatusScreen extends StatefulWidget {
  const SetStatusScreen({Key? key}) : super(key: key);

  @override
  State<SetStatusScreen> createState() => _SetStatusScreenState();
}

class _SetStatusScreenState extends State<SetStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
