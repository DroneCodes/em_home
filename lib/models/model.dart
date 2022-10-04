import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String password;

  User({
    required this.uid,
    required this.email,
    required this.password,
  });

  // adding functions to user so we can easily access from firebase

  // this would convert the User class to an object file
  Map<String, dynamic> toJson() =>
      {
        "uid": uid,
        "email": email,
        "password": password,
      };

  // create a function that takes a document snapshot and return a data model
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
      password: snapshot["password"],
    );
  }
}

class UserProfile {
  final String name;
  final String birthday;
  final String address;
  final String photoUrl;

  UserProfile(
      {required this.name,
      required this.birthday,
      required this.address,
      required this.photoUrl});

  Map<String, dynamic> toJson() => {
        "name": name,
        "birthday": birthday,
        "address": address,
        "photoUrl": photoUrl,
      };

  static UserProfile fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserProfile(
      name: snapshot["name"],
      birthday: snapshot["birthday"],
      address: snapshot["address"],
      photoUrl: snapshot["photoUrl"],
    );
  }
}
