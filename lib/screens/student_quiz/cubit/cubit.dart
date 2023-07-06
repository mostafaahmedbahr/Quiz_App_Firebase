
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




  storeStudentScore({
    required String examName,
    required String administratorCode,
    required String examPassword,
    required String studentCode,
    required String studentImage,
    required String studentName,
    required int totalQuestions,
    required int correctAnswers,
    required dynamic questions,
    required dynamic studentAnswers,
})
  async {
    emit(StoreStudentScoreLoadingState());
    var scoreCollection  = await FirebaseFirestore.instance.collection("students_score")
        .doc("${SharedPreferencesHelper.getData(key: "uId")}");
    final scoreData = {
      "id" : SharedPreferencesHelper.getData(key: "uId"),
      'studentName': studentName,
      'studentCode': studentCode,
      'studentImage': studentImage,
      'examName': examName,
      'administratorCode': administratorCode,
      'examPassword': examPassword,
      'total_questions':  totalQuestions,
      'correctAnswer':  correctAnswers,
      "studentAnswers" : studentAnswers,
      'questions': questions.map((q) => {
        'id': q["id"],
        'question': q["question"],
        'answers': q["answers"],
        'correctAnswer': q["correctAnswer"],
      }).toList(),
    };
    scoreCollection.set(scoreData).then((value){
      print("----------success -----------");
      emit(ScoreStudentAnswersSuccessState());
    }).catchError((error){
      print("error in score student answers ${error.toString()}");
      emit(ScoreStudentAnswersErrorState());
    });
  }




  scoreStudentAnswers({
    required dynamic answersStudents,
})
  async {
   emit(ScoreStudentAnswersLoadingState());
    var answersCollection  = await FirebaseFirestore.instance.collection("students_answers").doc("${SharedPreferencesHelper.getData(key: "uId")}");
   answersCollection.set({
     'answersStudents': answersStudents.map((a) => {
       'id': a.id,
       'question': a.question,
       'answers': a.answers,
       'correctAnswer': a.correctAnswer,
     }).toList(),
   }).then((value){
     print("----------success -----------");
     emit(ScoreStudentAnswersSuccessState());
   }).catchError((error){
     print("error in score student answers ${error.toString()}");
     emit(ScoreStudentAnswersErrorState());
   });
  }
}