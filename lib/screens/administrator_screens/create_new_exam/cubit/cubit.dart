
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/Sh/shared_pref.dart';
 import 'package:quiz_app_new/screens/administrator_screens/create_new_exam/cubit/states.dart';

import '../create_exam2.dart';
import '../../../../models/exam_model.dart';




class CreateNewExamCubit extends Cubit<CreateNewExamStates> {
  CreateNewExamCubit() : super(CreateNewExamInitState());

  static CreateNewExamCubit get(context) => BlocProvider.of(context);
//
//   Question question = Question();
//   addNewExam({
//     required String examName,
//     required String adminCode,
//     required String examPassword,
//     required dynamic questions,
// })
//   {
//     emit(AddNewExamLoadingState());
//     FirebaseFirestore.instance.collection("AllUsers")
//         .doc("${SharedPreferencesHelper.getData(key: "AdminUId")}")
//         .collection("exams").doc("").set(
//         {
//           "examName" : examName,
//           "adminCode" : adminCode,
//           "examPassword" : examPassword,
//           "questions" : questions,
//         }).then((value){
//       emit(AddNewExamSuccessState());
//     }).catchError((error)
//     {
//       print(error.toString());
//       emit(AddNewExamErrorState());
//     });
//   }



  ExamModel? examModel;


  addExamToFirebase({

    required String examName,
    required String administratorCode,
    required String examPassword,
    required dynamic questions,

})
  async {
    emit(AddNewExamLoadingState());
    final CollectionReference examsRef = FirebaseFirestore.instance.collection('exams');
    final examData = {
      'examName': examName,
      'administratorCode': administratorCode,
      'examPassword': examPassword,
      'questions': questions.map((q) => {
        'id': q.id,
        'question': q.question,
        'answers': q.answers,
        'correctAnswer': q.correctAnswer,
      }).toList(),
    };
    try {
      // Add the exam data to Firestore
      await examsRef.doc(SharedPreferencesHelper.getData(key: "AdminUId")).set(examData);
      // Navigate to the success screen
      emit(AddNewExamSuccessState());

    } catch (e) {
      // Show an error message if adding the data to Firestore fails
      print('Failed to add exam data to Firestore.');
      emit(AddNewExamErrorState());
    }
  }
}