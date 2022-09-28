import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  const UserProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  bool isLoading = false;
  var userData = {};

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .collection("user details")
          .doc()
          .get();
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "My Profile",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      userData["profilePics"],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        child: Text(
                          "Name",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),

                      SizedBox(
                        width: 150,
                        child: Text(
                          userData["name"]
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
