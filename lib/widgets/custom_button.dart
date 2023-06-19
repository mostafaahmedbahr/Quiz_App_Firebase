import 'package:flutter/material.dart';

 class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.height,   this.width,   required this.btnColor, required this.btnText,required this.onPressed}) : super(key: key);
  final double height;
  final double? width;

  final Color btnColor;
  final Widget btnText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return    SizedBox(
      height: height,
      width: width,
      child:  ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          primary: btnColor,
          //backgroundColor: btnColor,
        ),
        child:  btnText,
      ),
    );
  }
}