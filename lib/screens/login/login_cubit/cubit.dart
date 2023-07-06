import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/login/login_cubit/states.dart';

import '../../../Sh/shared_pref.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var emailCon = TextEditingController();
  var passCon = TextEditingController();



  bool isVisible = true;
  void changeSuffixIcon()
  {
    isVisible =! isVisible;
    emit(ChangeSuffixIconState());
  }


   login({
     required String email,
     required String password,
})async
   {
     emit(LoginLoadingState());
     await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password,
     ).then((value){
       print(value.user!.uid);
       print("0"*20);
       SharedPreferencesHelper.saveData(key: "uId", value: value.user!.uid);
       SharedPreferencesHelper.saveData(key: "isAdmin", value: false);
       print(value.user!.email);
       emit(LoginSuccessState());
     }).catchError((error)
     {
       print("error in login cubit ${error.toString()}");
       emit(LoginErrorState(errorMsg: error.toString()));
     });

   }


  List  allUsers = [];
  getUserDataInHome()
  {
    emit(GetUserDataLoadingState());
    allUsers = [];
    FirebaseFirestore.instance.collection("AllUsers")
        .where("id" , isEqualTo: SharedPreferencesHelper.getData(key: "uId"))
        .get().then((value)
    {
      for (var element in value.docs) {
        allUsers.add(element );
      }
      debugPrint(allUsers.length.toString());
      print(allUsers[0]["isAdmin"]);
      SharedPreferencesHelper.saveData(key: "uId", value: allUsers[0]["id"]);
      SharedPreferencesHelper.saveData(key: "isAdmin", value: false);
      debugPrint("6"*20);
      emit(GetUserDataSuccessState());
    }).catchError((error)
    {
      print("error in get all users data ${error.toString()}");
      emit(GetUserDataErrorState());
    });
  }



   }