import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/user.dart';

class CreateHomeScreen extends StatefulWidget {
  const CreateHomeScreen({Key? key}) : super(key: key);

  @override
  State<CreateHomeScreen> createState() => _CreateHomeScreenState();
}

class _CreateHomeScreenState extends State<CreateHomeScreen> {

  final TextEditingController homenameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homenameController.dispose();
  }

  // Future<String> uploadImageToStorage(String childName, Uint8List file) {
  //   Reference ref = storage
  // }

  Future createHome() async{
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String homeid = const Uuid().v1();
    final homes = Home(
        users: [],
        name: homenameController.text,
        homeid: homeid
    );
    await _firestore.collection("homes").doc(homeid).set(homes.toJson());
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CircularProgressIndicator()));
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                textAlign: TextAlign.center,
                "Give your Home a name",
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(
                height: 35,
              ),

              TextFieldInput(
                textEditingController: homenameController,
                hintText: "Name",
                textInputType: TextInputType.text,
              ),

              const SizedBox(
                height: 50,
              ),


              GestureDetector(
                onTap: createHome,
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
                    "Create code",
                    style: TextStyle(
                        color: buttonTextColor, fontWeight: FontWeight.bold),
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Future<String> createHome(
//     String uid,
//     ) async {
//   String res = "some error occured";
//   try {
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     String homeid = const Uuid().v1();
//     Home homes = Home(
//         users: [],
//         uid: uid,
//         // use the uuid package
//         name: homenameController.text,
//         homeid: homeid
//     );
//     await _firestore.collection("homes").doc(uid).set(homes.toJson());
//     res = "success";
//   } catch (err) {
//     res = err.toString();
//   }
//   return res;
// }
// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CircularProgressIndicator()));
// }
