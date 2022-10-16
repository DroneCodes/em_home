import 'package:em_home/drawer/navigation_drawer.dart';
import 'package:em_home/methods/auth_method.dart';
import 'package:em_home/screens/homes/search_page.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import '../../methods/database_service.dart';
import '../../methods/helper_functions.dart';
import '../../models/model.dart';
import '../../utils/colors.dart';
import '../../widgets/home_file.dart';

class HomesPage extends StatefulWidget {
  const HomesPage({Key? key}) : super(key: key);

  @override
  State<HomesPage> createState() => _HomesPageState();
}

class _HomesPageState extends State<HomesPage> {
  final AuthMethods _authMethods = AuthMethods();
  String userName = "";
  String email = "";
  Stream? homes;
  bool _isLoading = false;
  String homeName = "";
  String address = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getAddress(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserHomes()
        .then((snapshot) {
      setState(() {
        homes = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, CustomRoute(widget: const SearchPage()));
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text(
          "Homes",
          style: TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 27),
        ),
      ),
      drawer: const NavigationDrawer(),
      body: homesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: backgroundColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a home",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? const Center(child: CircularProgressIndicator())
                      : TextField(
                          onChanged: (val) {
                            setState(() {
                              homeName = val;
                            });
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: backgroundColor),
                                borderRadius: BorderRadius.circular(20)),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: backgroundColor),
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Name of Home",
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (val) {
                      setState(() {
                        address = val;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: backgroundColor),
                          borderRadius: BorderRadius.circular(20)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: backgroundColor),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Name of Home",
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(primary: backgroundColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (homeName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .createHome(userName, homeName,
                              FirebaseAuth.instance.currentUser!.uid, address)
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                      showSnackBar("Home created successfully.", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: backgroundColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }

  showSnackBar(String content, context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  homesList() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['homes'] != null) {
            if (snapshot.data['homes'].length != 0) {
              return ListView.builder(
                  itemCount: snapshot.data['homes'].length,
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        snapshot.data['homes'].length - index - 1;
                    return HomeTile(
                      homeId: getId(snapshot.data['homes'][reverseIndex]),
                      userName: snapshot.data['fullName'],
                      homeName: getName(snapshot.data['homes'][reverseIndex]),
                    );
                  });
            } else {
              return noHomeWidget();
            }
          } else {
            return noHomeWidget();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      stream: homes,
    );
  }

  noHomeWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any home, tap on the add icon to create a home or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
