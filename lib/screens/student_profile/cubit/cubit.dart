
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:quiz_app_new/screens/student_profile/cubit/states.dart';

import '../../../Sh/shared_pref.dart';
import '../../../models/student_profile_model.dart';


class StudentProfileCubit extends Cubit<StudentProfileStates> {
  StudentProfileCubit() : super(StudentProfileInitState());

  static StudentProfileCubit get(context) => BlocProvider.of(context);

  StudentProfileModel? studentProfileModel;
  getUserDataInProfile()
  {
    emit(GetStudentProfileDataLoadingState());
    FirebaseFirestore.instance.collection("AllUsers").doc(SharedPreferencesHelper.getData(key: "uId")).get().then((value)
    {
      print(value.data());
      studentProfileModel = StudentProfileModel.fromJson(value.data());
      emit(GetStudentProfileDataSuccessState());
    }).catchError((error)
    {
      print("error in get user data ${error.toString()}");
      emit(GetStudentProfileDataErrorState());
    });
  }


  logout()async
  {
    SharedPreferencesHelper.removeData(key: "uId");
    await FirebaseAuth.instance.signOut();
    print("----------");
    emit(LogoutSuccessState());
  }



  List allStudentAnswers = [];
  getAllAnswers()
  {
    emit(GetAllStudentsScoreLoadingState());
    allStudentAnswers = [];
    FirebaseFirestore.instance.collection("students_score")
        .where('id', isEqualTo:  SharedPreferencesHelper.getData(key: "uId")).get().then((value)
    {
      for (var element in value.docs) {
        allStudentAnswers.add(element);
      }
      debugPrint(allStudentAnswers.length.toString());
      debugPrint("6"*20);
      emit(GetAllStudentsScoreSuccessState());
    }).catchError((error)
    {
      print("error in get all data ${error.toString()}");
      emit(GetAllStudentsScoreErrorState());
    });
  }

}