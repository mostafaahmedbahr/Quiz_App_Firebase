import 'package:flutter/material.dart';

const kPrimartColor = Color.fromRGBO(99, 9, 167, 1);
const kTextColor = Color.fromRGBO(164, 92, 217, 1);
const kBackgroundColor = Color.fromRGBO(241, 241, 241, 1);

const double kDefaultPadding = 10.0;
Color p = const Color.fromRGBO(164, 94, 217, 1);

Color y = const Color.fromRGBO(253, 190, 82, 1);

Color m = const Color.fromRGBO(99, 9, 167, 1);

Widget buildText(String str, double fontSize,
    {TextAlign alignment = TextAlign.center}) {
  const color = Color(0xFF6309A7);
  final style = TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
  );
  return Text(
    str,
    style: style,
    textAlign: alignment,
  );
}

Padding buildTextFormField(
    String initialValue, String hintText, ValueChanged<String> onChanged) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        hoverColor: const Color.fromRGBO(164, 94, 217, 1),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromRGBO(164, 94, 217, 1)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide:
          BorderSide(color: Color.fromRGBO(164, 94, 217, 1), width: 2),
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
