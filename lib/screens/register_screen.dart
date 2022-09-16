import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/methods/auth_method.dart';
import 'package:em_home/methods/methods.dart';
import 'package:em_home/screens/choose_home_screen.dart';
import 'package:em_home/screens/login_screen.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:em_home/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:em_home/models/user.dart' as model;
import 'package:image_picker/image_picker.dart';

import '../utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  Uint8List? image;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() async {
    setState(() {
      _isLoading = true;
    });

    // function to select image
    pickImage(ImageSource source) async {
      final ImagePicker imagePicker = ImagePicker();

      XFile? _file = await imagePicker.pickImage(source: source);

      if (_file != null) {
        return await _file.readAsBytes();
      }
      print("No Image selected");
    }

    void selectImage() async {
      Uint8List? im = await pickImage(ImageSource.gallery);
      setState(() {
        image = im;
      });
    }

    // function to register user
    String res = await AuthMethods().registerUser(
        email: emailController.text, password: passwordController.text, file: image!);
    setState(() {
      _isLoading = false;
    });

    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ChooseHomeScreen()));
    }
  }

  void navigatetoSignIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
            color: backgroundColor,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, SlideLeftRoute(widget: const LoginScreen()));
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
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
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
                        onTap: signUp,
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
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: iconButtonColor,
                                  ),
                                )
                              : const Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: buttonTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
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
