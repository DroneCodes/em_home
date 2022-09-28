import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/methods/auth_method.dart';
import 'package:em_home/screens/choose_home_screen.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import '../providers/user_provider.dart';

class AboutYouPage extends StatefulWidget {
  const AboutYouPage({Key? key}) : super(key: key);

  @override
  State<AboutYouPage> createState() => _AboutYouPageState();
}

class _AboutYouPageState extends State<AboutYouPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/logos.png",
            ),
            const Text(
              "About You",
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
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
              height: 40,
            ),
            TextFieldInput(
              textEditingController: nameController,
              hintText: "Name",
              textInputType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: dobController,
              hintText: "Date of Birth",
              textInputType: TextInputType.datetime,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: genderController,
              hintText: "Gender",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                await AuthMethods().addUserDetails(
                  nameController.text,
                  genderController.text,
                  dobController.text,
                  image!
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChooseHomeScreen()));
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
    );
  }
}
