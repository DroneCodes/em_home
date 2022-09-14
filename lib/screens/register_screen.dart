import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/methods/methods.dart';
import 'package:em_home/screens/choose_home_screen.dart';
import 'package:em_home/screens/login_screen.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:em_home/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:em_home/models/user.dart' as model;

import '../utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<String> registerUser() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // String photoUrl = await Storage().uploadImage("profile pics", file);
      model.User user = model.User(
          uid: credential.user!.uid,
          email: emailController.text,
          // photoUrl: photoUrl
      );
      // add user to database

      await firebaseFirestore.collection("users").doc(credential.user!.uid).set(user.toJson());

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return "Success";
  }


  void navigatetoSignIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, SlideLeftRoute(widget: const LoginScreen()));
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logos.png',
                  ),
                  const Text(
                    "Create your account",
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldInput(
                      textEditingController: emailController,
                      hintText: "Username or email",
                      textInputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldInput(
                    textEditingController: passwordController,
                    hintText: "Password",
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldInput(
                    textEditingController: passwordController,
                    hintText: "Confirm Password",
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      registerUser();
                      Navigator.pushReplacement(context, CustomRoute(widget: const ChooseHomeScreen()));
                    },
                    child: Container(
                        width: double.infinity,
                        alignment: AlignmentDirectional.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: buttonColor,
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: buttonTextColor, fontWeight: FontWeight.bold),
                        ),),
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Container(
                    color: backgroundColor,
                    child: const Text("- or sign in using -"),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 50,
                          height: 45,
                          color: Colors.white,
                          child: Image.asset('assets/google.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        child: Container(
                          width: 50,
                          height: 45,
                          color: Colors.white,
                          child: Image.asset('assets/facebook.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
