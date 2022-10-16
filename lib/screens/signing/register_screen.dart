import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/methods/auth_method.dart';
import 'package:em_home/screens/signing/login_screen.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../methods/helper_functions.dart';
import '../../utils/colors.dart';
import '../../widgets/text_field.dart';

enum Gender {
  male, female
}

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

  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  String dob = "";
  Gender? gender = Gender.male;
  AuthMethods authMethods = AuthMethods();
  Uint8List? image;

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? _file = await imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("No Image selected");
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }


  signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authMethods.registerUser(email: email, password: password, name: fullName, gender: gender.toString(), dateOfBirth: dob, file: image!,)
      .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);

          Navigator.pushReplacement(context, SlideLeftRoute(widget: const LoginScreen()));
        } else {
          showSnackBar(value, context);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    return null;
  }

  void navigatetoSignIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            color: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, SlideLeftRoute(widget: const LoginScreen()));
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                Stack(
                  children: [
                    // to check if Image is not equal to null
                    image != null
                        ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(image!),
                    )
                        : const CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage(
                        "assets/default_profile.jpg",
                      ),
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                      left: 80,
                      bottom: -10,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.email,
                      )),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },

                  // check tha validation
                  validator: (val) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val!)
                        ? null
                        : "Please enter a valid email";
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                      labelText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                      )),
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Password must be at least 6 characters";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: "Full Name",
                      prefixIcon: Icon(
                        Icons.person,
                      )),
                  onChanged: (val) {
                    setState(() {
                      fullName = val;
                    });
                  },
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      return null;
                    } else {
                      return "Name cannot be empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: "Date Of Birth DD/MM/YYYY",
                      prefixIcon: Icon(
                        Icons.calendar_month,
                      )),
                  validator: (val) {},
                  onChanged: (val) {
                    setState(() {
                      dob = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    genderDialog(context);
                  },
                  child: Container(
                    child: Icon(
                      Icons.person
                    ),
                  ),
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
                  height: 50,
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
                      onTap: () {
                        Navigator.push(context, CustomRoute(widget: const Scaffold(body: Center(child: Text("Coming Soon"),))));
                      },
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
                      onTap: () {
                        Navigator.push(context, CustomRoute(widget: const Scaffold(body: Center(child: Text("Coming Soon"),))));
                      },
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
        ),
      ),
    );
  }

  genderDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (((context, setState) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text("Female"),
                leading: Radio<Gender>(
                  value: Gender.female,
                  groupValue: gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ListTile(
                title: const Text("Male"),
                leading: Radio<Gender>(
                  value: Gender.male,
                  groupValue: gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              )
            ],
          ),
        );
      })));
    });
  }
}
