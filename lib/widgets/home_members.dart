import "package:flutter/material.dart";

class HomeMembers extends StatefulWidget {
  final String username;
  final String photoUrl;
  final String status;
  const HomeMembers({Key? key, required this.username, required this.photoUrl, required this.status}) : super(key: key);

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
                        widget.photoUrl,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.username, style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.46), fontSize: 10),),
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

                    Text(widget.status, style: const TextStyle(fontStyle: FontStyle.italic, color: Color.fromRGBO(0, 0, 0, 0.46),),)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
