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
  Map<String, dynamic> toJson() => {
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

class UserProfile {
  final String name;
  final String birthday;
  final String address;
  final String photoUrl;

  UserProfile({
    required this.name,
    required this.birthday,
    required this.address,
    required this.photoUrl
  });

  Map<String, dynamic> toJson() =>
      {
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
