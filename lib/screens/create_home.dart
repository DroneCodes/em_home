import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/model.dart';
import 'home_screen.dart';

class CreateHomeScreen extends StatefulWidget {
  const CreateHomeScreen({Key? key}) : super(key: key);

  @override
  State<CreateHomeScreen> createState() => _CreateHomeScreenState();
}

class _CreateHomeScreenState extends State<CreateHomeScreen> {
  final TextEditingController homeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
  }



  Future createHome() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String homeid = const Uuid().v1();
    final homes = Home(
      users: [],
      name: homeNameController.text,
      homeid: homeid,
      address: addressController.text,
      city: cityController.text,
      state: stateController.text,
      zip: zipController.text,

    );
    await _firestore.collection("homes").doc(homeid).set(homes.toJson());
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                  "assets/logos.png",
              ),

              Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      "Home Name",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),

                  SizedBox(
                    width: 150,
                    child: TextFieldInput(
                        textEditingController: homeNameController,
                        hintText: "Home Name",
                        textInputType: TextInputType.name,
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      "Address",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),

                  SizedBox(
                    width: 150,
                    child: TextFieldInput(
                      textEditingController: addressController,
                      hintText: "Address",
                      textInputType: TextInputType.name,
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      "City",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),

                  SizedBox(
                    width: 150,
                    child: TextFieldInput(
                      textEditingController: cityController,
                      hintText: "City",
                      textInputType: TextInputType.name,
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              Row(
                children: [
                  const SizedBox(
                    width: 20,
                    child: Text(
                      "State",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),

                  SizedBox(
                    width: 80,
                    child: TextFieldInput(
                      textEditingController: stateController,
                      hintText: "",
                      textInputType: TextInputType.name,
                    ),
                  ),

                  const SizedBox(
                    width: 13,
                  ),

                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                        child: Text(
                          "Zip",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),

                      SizedBox(
                        width: 50,
                        child: TextFieldInput(
                          textEditingController: zipController,
                          hintText: "",
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ],
                  )

                ],
              ),

              const SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: createHome,
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
                    "Create Home",
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