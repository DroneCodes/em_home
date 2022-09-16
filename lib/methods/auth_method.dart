
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:em_home/methods/methods.dart';
import 'package:em_home/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Function to register user
  Future<String> registerUser({
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String profilePhoto = await Storage().uploadImage("profile pics", file);
        model.User user =
            model.User(uid: cred.user!.uid, email: email, password: password, profilePhoto: profilePhoto,);
        // add user to database
        await firebaseFirestore
            .collection("users")
            .doc(cred.user!.uid)
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
}

