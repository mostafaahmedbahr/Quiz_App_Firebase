import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../student_profile/profile_st.dart';
import '../../conctant.dart';
import '../../favorite.dart';
import '../student_home/home.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}
class _LayoutState extends State<Layout> {


  // ignore: prefer_final_fields




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBarCubit,NavBarStates>(
      listener:  (context,state){},
        builder: (context,state){
        var cubit = NavBarCubit.get(context);
          return SafeArea(
            child: Scaffold(
                body: cubit.screens[NavBarCubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  // ignore: prefer_const_literals_to_create_immutables
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite_border), label: 'Favorite'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.account_circle_outlined), label: 'Account'),
                    ],
                    onTap: (index){
                      cubit.changeItem(index);
                    },
                    currentIndex: NavBarCubit.currentIndex,
                    selectedItemColor: kPrimartColor,
                    //  backgroundColor: Colors.purpleAccent[400],
                    unselectedItemColor: Colors.grey)),
          );
        },

    );
  }
}
