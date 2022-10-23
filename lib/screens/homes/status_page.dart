import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_home/screens/homes/home_info.dart';
import 'package:em_home/utils/colors.dart';
import 'package:em_home/utils/custom_route.dart';
import 'package:em_home/widgets/home_members.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../methods/database_service.dart';

class StatusPage extends StatefulWidget {
  final String homeId;
  final String homeName;
  final String userName;
  const StatusPage({
    Key? key,
    required this.homeId,
    required this.homeName,
    required this.userName,
  }) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  Stream<QuerySnapshot>? status;
  TextEditingController statusController = TextEditingController();
  String admin = "";
  Stream? members;

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getStatus(widget.homeId).then((val) {
      setState(() {
        status = val;
      });
    });
    DatabaseService().getHomeAdmin(widget.homeId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }
  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  getMembers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getHomeMembers(widget.homeId)
        .then((val) {
      setState(() {
        members = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        foregroundColor: backgroundColor,
        centerTitle: true,
        elevation: 0,
        title: Text(widget.homeName),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CustomRoute(
                        widget: HomeInfo(
                      adminName: admin,
                      homeName: widget.homeName,
                      homeId: widget.homeId,
                    )));
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          homeMembers(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  controller: statusController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Set a Status...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendStatus();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  statusMessages() {
    return StreamBuilder(
      stream: status,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return StatusTile(
                      status: snapshot.data.docs[index]['status'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

  homeMembers() {
    return StreamBuilder(
        stream: members, builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data['members'] != null) {
          if (snapshot.data['members'].length != 0) {
            return ListView.builder(
              itemCount: snapshot.data['members'].length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 6,
                        color: Colors.green,
                        width: 20,
                      ),

                      const SizedBox(
                        width: 20,
                      ),

                      Container (
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        color: Colors.white,
                        height: 350,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                  ),
                                  child: Image.asset(
                                    snapshot.data['members']['profilePic'],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(getName(snapshot.data['members'][index]), style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.46), fontSize: 10),),
                              ],
                            ),

                            const SizedBox(
                              width: 15,
                            ),

                            Column(
                              children: [
                                const Text("Status", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(snapshot.data.docs[index]['status'], style: const TextStyle(fontStyle: FontStyle.italic, color: Color.fromRGBO(0, 0, 0, 0.46),),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        } else {
          return const CircularProgressIndicator();
        }
      }else {
        return const CircularProgressIndicator();
      }
    });
  }

  sendStatus() {
    if (statusController.text.isNotEmpty) {
      Map<String, dynamic> statusMap = {
        "status": statusController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendStatus(widget.homeId, statusMap);
      setState(() {
        statusController.clear();
      });
    }
  }
}

class StatusTile extends StatefulWidget {
  final String status;
  final String sender;
  final bool sentByMe;

  const StatusTile(
      {Key? key,
      required this.status,
      required this.sender,
      required this.sentByMe})
      : super(key: key);

  @override
  State<StatusTile> createState() => _StatusTileState();
}

class _StatusTileState extends State<StatusTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sentByMe ? 0 : 24,
          right: widget.sentByMe ? 24 : 0),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: widget.sentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            color: widget.sentByMe ? backgroundColor : Colors.grey[700]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sender.toUpperCase(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(widget.status,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 16, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
