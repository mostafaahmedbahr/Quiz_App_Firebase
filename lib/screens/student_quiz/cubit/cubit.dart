
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/student_quiz/cubit/states.dart';

import '../../../Sh/shared_pref.dart';

class StudentQuizCubit extends Cubit<StudentQuizStates> {
  StudentQuizCubit() : super(StudentQuizInitState());

  static StudentQuizCubit get(context) => BlocProvider.of(context);



  int score = 0;

  List allQuiz = [];
  List allQuestions = [];
  getAllQuiz()
  {
    emit(GetAllQuizLoadingState());
    allQuiz = [];
    FirebaseFirestore.instance.collection("exams").get().then((value)
    {
      for (var element in value.docs) {
        allQuiz.add(element);

      }
      debugPrint(allQuiz.length.toString());
      print(allQuiz[0]["questions"].length);
      debugPrint("6"*20);
      emit(GetAllQuizSuccessState());
    }).catchError((error)
    {
      print("error in get all data ${error.toString()}");
      emit(GetAllQuizErrorState());
    });
  }
}