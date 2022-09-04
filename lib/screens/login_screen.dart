import 'package:em_home/screens/choose_home_screen.dart';
import 'package:em_home/screens/register_screen.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:em_home/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void navigatetoSignUp() {
    Navigator.pushReplacement(context, SlideLeftRoute(widget: const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/logos.png',
              ),
              const Text(
                "Sign in to your account",
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

              InkWell(
                onTap: () {
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
                      "Log in",
                      style: TextStyle(
                          color: buttonTextColor, fontWeight: FontWeight.bold),
                    )),
              ),

              const SizedBox(
                height: 75,
              ),

              Container(
                color: backgroundColor,
                child: const Text("- or sign in using -"),
              ),

              const SizedBox(
                height: 25,
              ),

              Container(
                child: Row(
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
              ),

              const SizedBox(
                height: 60,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account? "),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigatetoSignUp,
                    child: Container(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
