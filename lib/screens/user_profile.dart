import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/methods/methods.dart';
import 'package:em_home/models/model.dart';

import 'package:em_home/utils/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/text_field.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  Uint8List? image;
  bool _isLoading = false;


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


  Future createHome(Uint8List file) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String profilePhoto = await Storage().uploadImageToStorage("profile pics", file);
    final userprofile = UserProfile(
        address: "${addressController.text}${address2Controller.text}", birthday: birthdayController.text, name: nameController.text, photoUrl: profilePhoto,

    );
    await _firestore.collection("user").doc().collection("UserProfile").doc().set(userprofile.toJson());
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const UserHomeScreen()));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor2,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Create Profile",
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 30,
              ),

              // create a circular widget to accept a file

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
                          backgroundImage:
                              AssetImage("assets/facebook.png"),),
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

              // Text Field Widgets

              const SizedBox(
                height: 25,
              ),

              Row(
                children: [
                  const Text(
                    "Name:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  TextFieldInput(
                    hintText: 'Name',
                    textInputType: TextInputType.text,
                    textEditingController: nameController,
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  const Text(
                    "Birthday:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  TextFieldInput(
                    hintText: 'Birthday',
                    textInputType: TextInputType.datetime,
                    textEditingController: birthdayController,
                  ),
                ],
              ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                const Text(
                  "Address:",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    TextFieldInput(
                      hintText: 'Line 1',
                      textInputType: TextInputType.streetAddress,
                      textEditingController: addressController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldInput(
                      hintText: 'Line 2',
                      textInputType: TextInputType.streetAddress,
                      textEditingController: address2Controller,
                    ),
                  ],
                ),
              ],
            ),

              const SizedBox(
                height: 45,
              ),

              InkWell(
                //onTap: createHome,
                child: Container(
                  width: double.infinity,
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: buttonColor2,
                  ),
                  child: _isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: iconButtonColor,
                    ),
                  )
                      : const Text(
                    "Move in!",
                    style: TextStyle(
                        color: buttonTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
