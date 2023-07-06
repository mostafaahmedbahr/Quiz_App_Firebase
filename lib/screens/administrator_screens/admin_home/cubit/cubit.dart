import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/administrator_screens/admin_home/cubit/states.dart';

import '../../../../Sh/shared_pref.dart';
import '../../../../models/admin_profile_model.dart';





class AdminHomeCubit extends Cubit<AdminHomeStates> {
  AdminHomeCubit() : super(AdminHomeInitState());

  static AdminHomeCubit get(context) => BlocProvider.of(context);


  AdminProfileModel? adminProfileModel;

  getUserDataInHome() {
    emit(GetAdminProfileDataLoadingState());
    FirebaseFirestore.instance.collection("AllUsers").doc(
        SharedPreferencesHelper.getData(key: "uId")).get().then((value) {
      print(value.data());
      adminProfileModel = AdminProfileModel.fromJson(value.data());
      emit(GetAdminProfileDataSuccessState());
    }).catchError((error) {
      print("error in get user data ${error.toString()}");
      emit(GetAdminProfileDataErrorState());
    });
  }

  adminLogout()async
  {
    SharedPreferencesHelper.removeData(key: "uId");
    SharedPreferencesHelper.removeData(key: "isAdmin");
    await FirebaseAuth.instance.signOut();
    print("----------");
    emit(LogoutSuccessState());
  }

}