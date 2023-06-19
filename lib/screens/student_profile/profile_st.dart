import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/core/nav.dart';
import 'package:quiz_app_new/screens/start/start.dart';
 import '../../conctant.dart';
import '../../core/toast/toast.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentProfileCubit,StudentProfileStates>(
      listener:(context,state){
        if(state is LogoutSuccessState){
          AppNav.customNavigator(
              context: context,
              screen: const MyStartPage(),
              finish: true,
          );
        }
      } ,
      builder: (context,state){
        var cubit = StudentProfileCubit.get(context);
        return ConditionalBuilder(
          condition: state is ! GetStudentProfileDataLoadingState,
          fallback: (context)=>Center(
            child: CircularProgressIndicator(
              color: myColor,
            ),
          ),
          builder: (context){
            return Scaffold(
              body: ListView(
                children: <Widget>[
                  const Padding(
                    padding:  EdgeInsets.all(20.0),
                    child: Center(
                      child:   Text('Profile',
                          style: TextStyle(
                              color: kPrimartColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
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
                      child:   Row(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.white70,
                                minRadius: 60.0,
                                child: CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage:
                                  NetworkImage(
                                      cubit.studentProfileModel?.image !=null ?
                                      "${cubit.studentProfileModel?.image}":
                                      'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                cubit.studentProfileModel?.name!=null ?
                                "${cubit.studentProfileModel?.name}" :
                                'Salem sleim',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                cubit.studentProfileModel?.grade !=null ?
                                    "Grade : ${cubit.studentProfileModel?.grade}" :
                                'Grade : 2',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimartColor.withOpacity(0.23)),
                          ]),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.purple[50],
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.account_circle,
                                  color: Colors.purple[100],
                                ),
                              ),
                            ),
                            title: const Text(
                              'My Account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: const Text(
                              'Make change to your account ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_right),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.purple[50],
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.dataset,
                                  color: Colors.purple[100],
                                ),
                              ),
                            ),
                            title: const Text(
                              'My Score',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: const Text(
                              'Show your Score ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_right),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.purple[50],
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.timeline_rounded,
                                  color: Colors.purple[100],
                                ),
                              ),
                            ),
                            title: const Text(
                              'Question Review',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: const Text(
                              'Show your Question Review ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_right),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.purple[50],
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.logout,
                                  color: Colors.purple[100],
                                ),
                              ),
                            ),
                            title: const Text(
                              'Log Out',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: const Text(
                              'Further secure your account for safety ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_right),
                            onTap: () {
                              cubit.logout();
                            },
                          ),
                          /*  Divider(),
                          ListTile(
                            title: Text(
                              'GitHub',
                              style: TextStyle(
                                color: kPrimartColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'https://github.com/leopalmeiro',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Linkedin',
                              style: TextStyle(
                                color: kPrimartColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'www.linkedin.com/in/leonardo-palmeiro-834a1755',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      } ,

    );
  }
}
