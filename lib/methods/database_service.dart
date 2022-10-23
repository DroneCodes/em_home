import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  final String? uid;

  DatabaseService({
    this.uid
  });

  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection("users");
  final CollectionReference homeCollection = FirebaseFirestore.instance
      .collection("homes");

  // saving userData
  Future updateUserData(String name, String email, String password, String gender, DateTime dob, String file) async {
    return await userCollection.doc(uid).set({
      'fullName': name,
      'email': email,
      'password': password,
      'homes': [],
      'profilePic': file,
      'gender': gender,
      'dateOfBirth': dob
    });
  }

  // create home

  Future createHome(String name, String homeName, String id, String address) async {
    DocumentReference homeRef = await homeCollection.add({
      "homeName": homeName,
      "homeIcon": "",
      "admin": "${id}_${name}",
      "members": [],
      "homeId": "",
      "recentStatus": "",
      "recentStatusSetter": "",
      "address": address,
    });

    await homeRef.update({
      "members": FieldValue.arrayUnion(["${id}_${name}"]),
      "homeId": homeRef.id
    });

    DocumentReference userRef = userCollection.doc(uid);
    return await userRef.update({
      "homes": FieldValue.arrayUnion(["${homeRef.id}_$homeName"])
    });
  }

  // toggling the homes user wants to join

  Future toggleHomeJoin(String homeId, String homeName, String name,) async {

    DocumentReference userRef = userCollection.doc(uid);
    DocumentReference homeRef = homeCollection.doc(homeId);


    DocumentSnapshot userSnapshot = await userRef.get();
    List<dynamic> homes = await userSnapshot["homes"];

    if(homes.contains("${homeId}_$homeName")) {
      await userRef.update({
        "homes": FieldValue.arrayRemove(["${homeId}_$homeName"])
      });

      await homeRef.update({
        "members": FieldValue.arrayRemove(["${uid}_$name"])
      });
    } else {
      await userRef.update({
        "homes": FieldValue.arrayUnion(["${homeId}_$homeName"])
      });

      await homeRef.update({
        "members": FieldValue.arrayUnion(["${uid}_$name"])
      });
    }
  }

  Future<bool> isUserJoined(String homeId, String homeName, String userName) async {

    DocumentReference userRef = userCollection.doc(uid);
    DocumentSnapshot userSnapshot = await userRef.get();

    List<dynamic> groups = await userSnapshot['homes'];


    if(groups.contains("${homeId}_$homeName")) {
      return true;
    }
    else {
      return false;
    }
  }


  // get user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  // get user homes
  getUserHomes() async {
    return userCollection.doc(uid).snapshots();
  }

  // search homes
  searchByName(String homeName) {
    return homeCollection.where('homeName', isEqualTo: homeName).get();
  }

  Future getHomeAdmin(String homeId) async {
    DocumentReference d = homeCollection.doc(homeId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // get home members
  getHomeMembers(homeId) async {
    return homeCollection.doc(homeId).snapshots();
  }

  getStatus(String homeId) async {
    return homeCollection
        .doc(homeId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  sendStatus(String homeId, Map<String, dynamic> statusData) async {
    homeCollection.doc(homeId).collection("status").add(statusData);
    homeCollection.doc(homeId).update({
      "recentStatus": statusData['status'],
      "recentStatusSetter": statusData['sender'],
      "recentStatusTime": statusData['time'].toString(),
    });
  }
}
