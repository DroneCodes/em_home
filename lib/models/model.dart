import 'package:cloud_firestore/cloud_firestore.dart';

// class User {
//   final String uid;
//   final String email;
//   final String name;
//   final String dob;
//   final String gender;
//   final String profilePic;
//
//   User({
//     required this.uid,
//     required this.email,
//     required this.name,
//     required this.dob,
//     required this.gender,
//     required this.profilePic,
//     required
//   });
//
//   // adding functions to user so we can easily access from firebase
//
//   // this would convert the User class to an object file
//   Map<String, dynamic> toJson() =>
//       {
//         "uid": uid,
//         "email": email,
//         "name": name,
//         "dob": dob,
//         "gender": gender,
//         "profilePic": profilePic,
//       };
//
//   // create a function that takes a document snapshot and return a data model
//   static User fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//
//     return User(
//       uid: snapshot["uid"],
//       email: snapshot["email"],
//       profilePic: snapshot["profilePic"],
//       name: snapshot["name"],
//       dob: snapshot["dob"],
//       gender: snapshot["gender"],
//     );
//   }
// }

class User {
  final String uid;

  User({
    required this.uid
  });
}
