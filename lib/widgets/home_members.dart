import "package:flutter/material.dart";

class HomeMembers extends StatefulWidget {
  const HomeMembers({Key? key}) : super(key: key);

  @override
  State<HomeMembers> createState() => _HomeMembersState();
}

class _HomeMembersState extends State<HomeMembers> {
  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(

            ),
          )
        ],
      ),
    );
  }
}
