import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/core/nav.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/administrator_screens/admin_home/cubit/cubit.dart';
import 'package:quiz_app_new/screens/administrator_screens/admin_home/cubit/states.dart';

import '../../../conctant.dart';
import '../create_new_exam/choose_exam_type.dart';
import '../create_new_exam/create new exam.dart';
import '../students_score/showExamResult.dart';
import '../../start/start.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminHomeCubit,AdminHomeStates>(
      listener:(context,state){
        if(state is LogoutSuccessState){
          AppNav.customNavigator(
              context: context,
              screen: MyStartPage(),
              finish: true,
          );
        }
      } ,
      builder: (context,state){
        var cubit = AdminHomeCubit.get(context);
        return  Scaffold(
          backgroundColor: const Color.fromRGBO(241, 241, 241, 0.9),
          appBar: AppBar(
            backgroundColor: myColor,
            leading: Text(""),
            centerTitle: true,
            title:  const Text(
              'Profile',
              style: TextStyle(
                color: kPrimartColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 130,
                  decoration: BoxDecoration(
                      color: kTextColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimartColor.withOpacity(0.23)),
                      ]),
                  child: ConditionalBuilder(
                    condition: state is ! GetAdminProfileDataLoadingState,
                    fallback: (context)=>Center(
                      child: CircularProgressIndicator(
                        color: myColor,
                      ),
                    ),
                    builder: (context){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                                CircleAvatar(
                                backgroundColor: Colors.white70,
                                minRadius: 30.0,
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage: NetworkImage(
                                      cubit.adminProfileModel!.image!=null ?
                                      "${cubit.adminProfileModel!.image}"    :
                                      'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Text(
                                  cubit.adminProfileModel!.name!=null ?
                                  "${cubit.adminProfileModel!.name}"  :
                                'Admin Name',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                                Text(
                                  cubit.adminProfileModel!.name!=null ?
                                      "Code : ${cubit.adminProfileModel!.code}" :
                                'Code : 0Xffff',
                                style: TextStyle(
                                  color: Color.fromRGBO(235, 235, 235, 1),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                         Text(""),
                        ],
                      );
                    },

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ChooseExamTypeScreen()));
                      },
                      child: buildContainer('Create Exam',
                          'https://www.iitms.co.in/college-erp/img/online-exam-icon.png'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>   StudentScore(

                                )));
                      },
                      child: buildContainer('Student Score',
                          'https://cdn1.iconfinder.com/data/icons/school-224/512/A_Exam-512.png'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0.8),
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    buildListTile('My Account', 'Make change to your account ',
                            () {}, Icons.person_2_outlined),
                    buildListTile(
                        'Log Out',
                        'Further secure your account for safety ',
                            () {
                          cubit.adminLogout();
                            },
                        Icons.logout)
                  ],
                ),
              ),
            ],
          ),
        );
      } ,
    
    );
  }

  Container buildContainer(String str, String url) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      height: 80,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 50,
                color: kPrimartColor.withOpacity(0.23)),
          ]),
      child: Column(children: [
        Image(
          image: NetworkImage(url),
          color: const Color.fromRGBO(248, 170, 36, 1),
          height: 40,
          width: 40,
        ),
        Text(
          str,
          style: const TextStyle(
            fontSize: 18,
            // fontWeight: FontWeight.bold,
            color: Color.fromRGBO(99, 9, 167, 1),
          ),
        ),
      ]),
    );
  }

  ListTile buildListTile(String titletext, String subtext, fun, IconData i) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.purple[50],
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            i,
            color: const Color.fromRGBO(88, 17, 142, 0.8),
          ),
        ),
      ),
      title: Text(
        titletext,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        subtext,
        style: const TextStyle(
          fontSize: 15,
          color: Color.fromRGBO(171, 171, 171, 1),
        ),
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: fun,
    );
  }
}
