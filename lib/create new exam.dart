import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/administrator_screens/create_new_exam/cubit/cubit.dart';
import 'package:quiz_app_new/screens/administrator_screens/create_new_exam/cubit/states.dart';

import 'create_exam2.dart';
import 'originalButton.dart';

// ignore: must_be_immutable
class CreateNewExam extends StatelessWidget {
  Color myColor = const Color.fromRGBO(88, 17, 142, 0.8);
  final TextEditingController eController = TextEditingController();
  final TextEditingController cController = TextEditingController();
  final TextEditingController pController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateNewExamCubit, CreateNewExamStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var formKey = GlobalKey<FormState>();
        var cubit = CreateNewExamCubit.get(context);
        return Scaffold(
          backgroundColor: const Color.fromRGBO(241, 241, 241, 0.9),
          appBar: AppBar(
            backgroundColor: myColor,
            title: Text(
              'Create New Exam',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildText(
                          str: 'Exam Name',
                          fontSize: 20,
                          myColor: myColor,
                        ),
                        buildTextFormField(
                            'Enter Exam Name', eController, myColor, (val) {
                          return "please enter the name ";
                        }),
                        buildText(
                            str: 'Administrator Name/Code',
                            fontSize: 20,
                            myColor: myColor),
                        buildTextFormField(
                            'Enter your Code', cController, myColor, (val) {
                          return "please enter the code ";
                        }),
                        buildText(
                            str: "Exam’s Results Password",
                            fontSize: 20,
                            myColor: myColor),
                        buildTextFormField(
                            'Enter PassWord', pController, myColor, (val) {
                          return "please enter the password ";
                        }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OriginalButton(
                            text: 'Next',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CreateExam2(
                                        examName: eController.text,
                                        administratorCode:
                                        cController.text,
                                        examPassword: pController.text,
                                      )));
                            },
                            bgcolor: const Color.fromRGBO(164, 94, 217, 1),
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Padding buildTextFormField(String str, TextEditingController con, Color c,
      String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(

        validator: validator,
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
