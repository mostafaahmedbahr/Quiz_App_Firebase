import 'package:flutter/material.dart';
class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({Key? key,   this.height,   this.width}) : super(key: key);
final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
