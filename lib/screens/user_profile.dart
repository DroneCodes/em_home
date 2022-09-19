import 'package:em_home/methods/auth_method.dart';
import 'package:em_home/screens/login_screen.dart';
import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: backgroundColor,
        actions: [
          IconButton(onPressed: () async{
            await AuthMethods().signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
          }, icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Container(),
    );
  }
}
