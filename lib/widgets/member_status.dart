import 'package:em_home/utils/colors.dart';
import 'package:flutter/material.dart';

class MemberStatus extends StatelessWidget {
  const MemberStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage("assets/facebook.png"),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Name",
                style: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: const [
              Text(
                "Status",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Notes/Add Notes",
                style: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
