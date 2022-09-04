import 'package:em_home/utils/colors.dart';
import 'package:em_home/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateHomeScreen extends StatelessWidget {
  const CreateHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextEditingController homenameController = TextEditingController();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
          padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                textAlign: TextAlign.center,
                "Give your Home a name",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(
                height: 35,
              ),

              TextFieldInput(
                textEditingController: homenameController,
                hintText: "Name",
                textInputType: TextInputType.text,
              ),

              const SizedBox(
                height: 50,
              ),


              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    color: buttonColor,
                  ),
                  child: const Text(
                    "Create code",
                    style: TextStyle(
                        color: buttonTextColor, fontWeight: FontWeight.bold),
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
