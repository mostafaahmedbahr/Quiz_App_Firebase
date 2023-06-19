import 'package:flutter/material.dart';

import 'create_exam2.dart';
import 'originalButton.dart';


// ignore: must_be_immutable
class createNewexam extends StatelessWidget {
  Color myColor = const Color.fromRGBO(88, 17, 142, 0.8);
  final TextEditingController eController = TextEditingController();
  final TextEditingController cController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 0.9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: myColor,
                ),
                Text(
                  'Create New Exam',
                  style: TextStyle(
                    color: myColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText(
                        str: 'Exam Name',
                        fontSize: 20,
                        myColor: myColor,
                      ),
                      buildTextFormField(
                          'Enter Exam Name', eController, myColor),
                      buildText(
                          str: 'Adminstrator Name/Code',
                          fontSize: 20,
                          myColor: myColor),
                      buildTextFormField(
                          'Enter your Code', cController, myColor),
                      buildText(
                          str: "Exam’s Results Password",
                          fontSize: 20,
                          myColor: myColor),
                      buildTextFormField(
                          'Enter Passeord', pController, myColor),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OriginalButton(
                          text: 'Next',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CreateExam2()));
                          },
                          bgcolor: const Color.fromRGBO(164, 94, 217, 1),
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Padding buildTextFormField(String str, TextEditingController con, Color c) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: con,
        cursorColor: myColor,
        decoration: InputDecoration(
          hoverColor: c,
          hintText: str,
          hintStyle: TextStyle(color: c),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: c, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
            BorderSide(color: Color.fromRGBO(99, 9, 167, 1), width: 2),
          ),
        ),
      ),
    );
  }
}

class buildText extends StatelessWidget {
  const buildText({
    super.key,
    TextAlign alignment = TextAlign.start,
    required this.str,
    required this.fontSize,
    required this.myColor,
  });

  final Color myColor;
  final String str;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        str,
        style: TextStyle(
          color: const Color(0xFF6309A7),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
