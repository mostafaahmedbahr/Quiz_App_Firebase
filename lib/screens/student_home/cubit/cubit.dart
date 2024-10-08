

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
      print(studentProfileModel!.isAdmin);
      print("bahr"*10);
      SharedPreferencesHelper.saveData(key: "isAdmin", value: studentProfileModel!.isAdmin);
      emit(GetStudentProfileDataSuccessState());
    }).catchError((error)
    {
      print("error in get user data ${error.toString()}");
      emit(GetStudentProfileDataErrorState());
    });
  }


  List allVideos = [];
  getAllVideos()
  async {
    emit(GetAllVidoesLoadingState());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("youtube_videos").get();
    FirebaseFirestore.instance.collection("youtube_videos").get().then((value)
    {
      allVideos = querySnapshot.docs.map((doc) => doc.data()).toList();
      print(allVideos);
      emit(GetAllVidoesSuccessState());
    }).catchError((error)
    {
      print("error in get all youtube_videos pdf data ${error.toString()}");
      emit(GetAllVidoesErrorState());
    });
  }

}