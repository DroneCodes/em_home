import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Container(
        child: Column(
          children: [
            CircleAvatar(
              child: Image.network(""),
            )
          ],
        ),
      ),
    );
  }
}
