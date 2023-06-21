 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/layout/cubit/states.dart';

import '../../fav/favorite.dart';
import '../../student_home/home.dart';
import '../../student_profile/profile_st.dart';


class NavBarCubit extends Cubit<NavBarStates> {
  NavBarCubit() : super(NavBarInitState());

  static NavBarCubit get(context) => BlocProvider.of(context);


  List<Widget> screens = <Widget>[
    const Home(),
    FavoritePage(),
    const StudentProfile(),
  ];


  static int currentIndex = 0;
    changeItem(value) {
    currentIndex = value;
    emit(ChangeCurrentIndexState());
  }
}