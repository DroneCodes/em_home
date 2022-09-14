import 'package:em_home/screens/create_home.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinHomeScreen extends StatefulWidget {
  const JoinHomeScreen({Key? key}) : super(key: key);

  @override
  State<JoinHomeScreen> createState() => _JoinHomeScreenState();
}

class _JoinHomeScreenState extends State<JoinHomeScreen> {

  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Enter your invite code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              PinCodeTextField(
                length: 5,
                appContext: context,
                obscureText: false,
                textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: textColor),
                pastedTextStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: textColor),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                onCompleted: (v) {
                  print("Completed");
                },
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 40),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {},
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
                    "Join!",
                    style: TextStyle(
                        color: buttonTextColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                textAlign: TextAlign.center,
                "Don't have a code",
                style: TextStyle(color: textColor, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context, SlideLeftRoute(widget: const CreateHomeScreen()));
                },
                child: Text(
                  textAlign: TextAlign.center,
                  "Create new",
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
