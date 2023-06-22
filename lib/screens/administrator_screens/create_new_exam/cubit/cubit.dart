
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/Sh/shared_pref.dart';
 import 'package:quiz_app_new/screens/administrator_screens/create_new_exam/cubit/states.dart';

import '../../../../create_exam2.dart';
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
}