
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/methods/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:em_home/models/model.dart' as model;
import 'package:uuid/uuid.dart';

import '../models/home_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // create a function to get the user details

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot = await firebaseFirestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snapshot);
  }

  Future<Home> getHomeDetails() async {
    DocumentSnapshot snap = await firebaseFirestore.collection("homes").doc().get();

    return Home.fromSnap(snap);
  }

  String userId = const Uuid().v1();
  // Function to register user
  Future<String> registerUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        model.User user =
            model.User(uid: userId, email: email, password: password,);
        // add user to database
        await firebaseFirestore
            .collection("users")
            .doc(userId)
            .set(user.toJson());

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




  Future<String> loginUser({required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch(e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async{
    _auth.signOut();
  }



  Future<void> addUserDetails(String name, String gender, String dateOfBirth,  Uint8List file) async {
    try {
      if(name.isNotEmpty || gender.isNotEmpty || dateOfBirth.isNotEmpty) {
        String detailsId = const Uuid().v1();
        String profileImage = await Storage().uploadImageToStorage("profilePics", file);
        await firebaseFirestore.collection("users").doc(userId).collection("user details").doc(detailsId).set({
          "name": name,
          "dateOfBirth": dateOfBirth,
          "gender": gender,
          "profilePics": profileImage,
        });
      } else {
        print("Fill up the required fields");
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}

