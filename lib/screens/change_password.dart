import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Image.asset("assets/logos.png"),
            const Text(
              "Change Password",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
      ),
    );
  }
}
