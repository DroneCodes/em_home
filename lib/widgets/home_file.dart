import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

import '../screens/homes/status_page.dart';

class HomeTile extends StatefulWidget {
  final String userName;
  final String homeId;
  final String homeName;
  const HomeTile(
      {Key? key,
      required this.homeId,
      required this.homeName,
      required this.userName,
      })
      : super(key: key);

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StatusPage(
                      homeId: widget.homeId,
                      homeName: widget.homeName,
                      userName: widget.userName,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: backgroundColor,
            child: Text(
              widget.homeName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.homeName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Join the home as ${widget.userName}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
