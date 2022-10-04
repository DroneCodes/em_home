import 'package:cloud_firestore/cloud_firestore.dart';

class Home {
  final List users;
  final String name;
  final String homeid;
  final String address;
  final String city;
  final String state;
  final String zip;

  Home({
    required this.users,
    required this.name,
    required this.homeid,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
  });

  // adding functions to user so we can easily access from firebase

  // this would convert the User class to an object file
  Map<String, dynamic> toJson() => {
    "users": users,
    "home": name,
    "homeid": homeid,
    "address": address,
    "city": city,
    "state": state,
    "zip": zip,
  };

  // create a function that takes a document snapshot and return a data model
  static Home fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Home(
      users: snapshot["users"],
      name: snapshot["home"],
      homeid: snapshot["homeid"],
      address: snapshot["address"],
      city: snapshot["city"],
      state: snapshot["state"],
      zip: snapshot["zip"],
    );
  }
}