import 'package:flutter/material.dart';
import '../screens/administrator_screens/admin_login/login_admin.dart';
import '../screens/login/loginSt.dart';
class OriginalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bgcolor;
  final Color textColor;

  const OriginalButton({super.key, required this.text, required this.onPressed, required this.bgcolor,required this.textColor, });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height:60,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor:MaterialStateProperty.all(bgcolor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),

        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 26),
        ),


      ),);
  }
}
