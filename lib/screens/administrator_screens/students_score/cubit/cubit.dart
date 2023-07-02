import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/administrator_screens/students_score/cubit/states.dart';

class ShowStudentsScoreCubit extends Cubit<ShowStudentsScoreStates> {
  ShowStudentsScoreCubit() : super(ShowStudentsScoreInitState());

  static ShowStudentsScoreCubit get(context) => BlocProvider.of(context);



  List allAnswers = [];
  getAllAnswers({
    required String examName,
    required String examPassword,
})
  {
    emit(GetAllStudentsScoreLoadingState());
    allAnswers = [];
    FirebaseFirestore.instance.collection("students_score")
        .where('examName', isEqualTo:  examName)
        .where('examPassword', isEqualTo: examPassword).get().then((value)
    {
      for (var element in value.docs) {
        allAnswers.add(element);
      }
      debugPrint(allAnswers.length.toString());
      debugPrint("6"*20);
      emit(GetAllStudentsScoreSuccessState());
    }).catchError((error)
    {
      print("error in get all data ${error.toString()}");
      emit(GetAllStudentsScoreErrorState());
    });
  }

}