import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  //final String photoUrl;

  User({
    required this.uid,
    required this.email,
    //required this.photoUrl
  });

  // adding functions to user so we can easily access from firebase

  // this would convert the User class to an object file
  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    // "photoUrl": photoUrl,
  };

  // create a function that takes a document snapshot and return a data model
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
      //photoUrl: snapshot["photoUrl"],
    );
  }
}


class Home {
  final List users;
  final String name;
  final String homeid;

  Home({
    required this.users,
    required this.name,
    required this.homeid
  });

  // adding functions to user so we can easily access from firebase

  // this would convert the User class to an object file
  Map<String, dynamic> toJson() => {
    "users": users,
    "home": name,
    "homeid": homeid
  };

  // create a function that takes a document snapshot and return a data model
  static Home fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Home(
      users: snapshot["users"],
      name: snapshot["home"],
      homeid: snapshot["homeid"]
    );
  }
}

