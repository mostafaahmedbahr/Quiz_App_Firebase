

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:quiz_app_new/screens/student_home/cubit/states.dart';

import '../../../Sh/shared_pref.dart';
import '../../../models/student_profile_model.dart';



class StudentHomeCubit extends Cubit<StudentHomeStates> {
  StudentHomeCubit() : super(StudentHomeInitState());

  static StudentHomeCubit get(context) => BlocProvider.of(context);


  StudentProfileModel? studentProfileModel;
  getUserDataInHome()
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

}