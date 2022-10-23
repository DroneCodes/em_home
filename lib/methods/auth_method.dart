
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/methods/database_service.dart';
import 'package:em_home/methods/methods.dart';
import 'package:em_home/models/model.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

import 'helper_functions.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Function to register user
  Future registerUser({
    required String email,
    required String password,
    required String name,
    required String gender,
    required DateTime dateOfBirth,
    required Uint8List file
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty || gender.isNotEmpty || file.isNotEmpty) {
        User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password)).user!;
        String profileImage = await Storage().uploadImageToStorage("profilePics", file);

        // create a new document for the user with uid
        if (user != null) {
          await DatabaseService(uid: user.uid).updateUserData(
              name, email, password, gender, dateOfBirth, profileImage);
          return true;
        }
        res = "success";
      }
      // for error during registering
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }




  Future loginUser({required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user!;
            if (user != null) {
              return true;
            }
      } else {
        res = "Please enter all the fields";
      }
    } catch(e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async{
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await _auth.signOut();
    } catch (e) {
      return null;
    }
  }



  // Future<void> joinHome(String uid, String homeid) async {
  //   try {
  //     DocumentSnapshot snap = await firebaseFirestore.collection("homes").doc(homeid).get();
  //      List users = (snap.data()! as dynamic)["users"];
  //
  //      // to remove the user if he is already a member
  //      if(users.contains(uid)) {
  //        await firebaseFirestore.collection("homes").doc(homeid).update({
  //          "users": FieldValue.arrayRemove([uid])
  //        });
  //      } else {
  //        // To add the user to an home
  //        await firebaseFirestore.collection("homes").doc(homeid).update({
  //          "users": FieldValue.arrayUnion([uid])
  //        });
  //      }
  //   } catch(e) {
  //     log(e.toString());
  //   }
  // }
}

