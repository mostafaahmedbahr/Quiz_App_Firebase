
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app_new/core/toast/toast_states.dart';
  class ToastConfig{

  static showToast({
    required String msg,
    required ToastStates toastStates,
  }) =>
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(toastStates),
        textColor: Colors.white,
        fontSize: 16.0,
      );
}

Color myColor = const Color.fromRGBO(88, 17, 142, 0.8);
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.Success:
      color = myColor;
      break;
    case ToastStates.Error:
      color =  Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }

  return color;
}

