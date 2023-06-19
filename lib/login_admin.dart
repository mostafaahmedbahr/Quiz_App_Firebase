import 'package:flutter/material.dart';

import 'conctant.dart';
import 'prof_admin.dart';

// ignore: must_be_immutable
class LoginAd extends StatefulWidget {
  const LoginAd({super.key});

  @override
  State<LoginAd> createState() => _LoginAdState();
}

class _LoginAdState extends State<LoginAd> {
  Color myColor = const Color.fromRGBO(88, 17, 142, 0.8);
  Color pColor = const Color.fromRGBO(164, 94, 217, 1);
// ignore: non_constant_identifier_names
  final TextEditingController EController = TextEditingController();
  final TextEditingController PController = TextEditingController();
  final TextEditingController CController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 0.9),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: myColor,
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 190, top: 40),
                  child: CircleAvatar(
                    radius: 57,
                    backgroundColor: Color.fromRGBO(255, 232, 104, 0.9),
                  ),
                ),
                Positioned(
                    top: 80,
                    left: 48,
                    child: buildText(
                        str: 'Welcome Back!',
                        fontSize: 24,
                        myColor: myColor,
                        alignment: TextAlign.center))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  str: 'Email',
                  fontSize: 20,
                  myColor: myColor,
                ),
                buildTextFormField('Enter your email', EController, p),
                buildText(str: 'password', fontSize: 20, myColor: myColor),
                buildTextFormField('Enter your password', PController, p),
                buildText(str: 'code', fontSize: 20, myColor: myColor),
                buildTextFormField(
                    'Enter your identifier code', CController, p),
                buildElevatedButton(context, 'Sign in')
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding buildElevatedButton(BuildContext context, String str) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: p,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Admin()));
        },
        child: Text(
          str,
          style: const TextStyle(
              fontSize: 25, color: Color.fromRGBO(241, 241, 241, 1)),
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

// ignore: camel_case_types
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
