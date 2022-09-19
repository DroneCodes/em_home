import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String password;
  // final String dateOfBirth;
  // final String phoneNumber;
  final String profilePhoto;
  // final String gender;
  // final String status;

  User({
    required this.uid,
    required this.email,
    required this.password,
    // required this.dateOfBirth,
    // required this.phoneNumber,
    required this.profilePhoto,
    // required this.gender,
    // required this.status,
  });

  // adding functions to user so we can easily access from firebase

  // this would convert the User class to an object file
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "password": password,
        // "dateOfBirth": dateOfBirth,
        // "phoneNumber": phoneNumber,
        "profilePhoto": profilePhoto,
        // "gender": gender,
        // "status": status,
      };

  // create a function that takes a document snapshot and return a data model
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
      password: snapshot["password"],
      // dateOfBirth: snapshot["dateOfBirth"],
      // phoneNumber: snapshot["phoneNumber"],
      profilePhoto: snapshot["profilePhoto"],
      // gender: snapshot["gender"],
      // status: snapshot["status"],
    );
  }
}

class Home {
  final List users;
  final String name;
  final String homeid;
  final String address;

  Home({
    required this.users,
    required this.name,
    required this.homeid,
    required this.address,
  });

  // adding functions to user so we can easily access from firebase

  // this would convert the User class to an object file
  Map<String, dynamic> toJson() =>
      {"users": users, "home": name, "homeid": homeid, "address": address};

  // create a function that takes a document snapshot and return a data model
  static Home fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Home(
        users: snapshot["users"],
        name: snapshot["home"],
        homeid: snapshot["homeid"],
        address: snapshot["address"]);
  }
}
