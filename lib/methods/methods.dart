import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImage(String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = (await UploadTask) as TaskSnapshot;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;

  }
}