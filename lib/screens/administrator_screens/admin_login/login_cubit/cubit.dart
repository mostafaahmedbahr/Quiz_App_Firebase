import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/administrator_screens/admin_login/login_cubit/states.dart';

import '../../../../Sh/shared_pref.dart';



class AdminLoginCubit extends Cubit<AdminLoginStates> {
  AdminLoginCubit() : super(AdminLoginInitialState());

  static AdminLoginCubit get(context) => BlocProvider.of(context);

  var emailCon = TextEditingController();
  var passCon = TextEditingController();



  bool isVisible = true;
  void changeSuffixIcon()
  {
    isVisible =! isVisible;
    emit(ChangeSuffixIconState());
  }


   adminLogin({
     required String email,
     required String password,
     required String code,
})async
   {
     emit(LoginLoadingState());
     await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password,
     ).then((value){
       print(value.user!.uid);
       print("0"*20);
       SharedPreferencesHelper.saveData(key: "AdminUId", value: value.user!.uid);
       print(value.user!.email);
       getUserDataInHome();
       emit(LoginSuccessState());
     }).catchError((error)
     {
       print("error in admin login cubit ${error.toString()}");
       emit(LoginErrorState(errorMsg: error.toString()));
     });

   }


  List  allUsers = [];
  getUserDataInHome()
  {
    // emit(GetUserDataLoadingState());
    allUsers = [];
    FirebaseFirestore.instance.collection("AllUsers")
        .where("id" , isEqualTo: SharedPreferencesHelper.getData(key: "AdminUId"))
        .get().then((value)
    {
      for (var element in value.docs) {
        allUsers.add(element );
      }
      debugPrint(allUsers.length.toString());
      debugPrint("6"*20);
      // emit(GetUserDataSuccessState());
    }).catchError((error)
    {
      print("error in get all users data ${error.toString()}");
      emit(GetUserDataErrorState());
    });
  }



   }