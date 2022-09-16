import 'package:em_home/methods/auth_method.dart';
import 'package:em_home/screens/choose_home_screen.dart';
import 'package:em_home/screens/register_screen.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:em_home/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(content)
        )
    );
  }


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signIn() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: emailController.text, password: passwordController.text);

    if (res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ChooseHomeScreen()));
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Sign in user with google

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // sign in with facebook... would be added soon
  //
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  void navigatetoSignUp() {
    Navigator.pushReplacement(
        context, SlideLeftRoute(widget: const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
              color: backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
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
                    onTap: signIn,
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
                        InkWell(
                          onTap: signInWithGoogle,
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
                        InkWell(
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
                  Flexible(
                    flex: 2,
                    child: Container(),
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
    );
  }
}
