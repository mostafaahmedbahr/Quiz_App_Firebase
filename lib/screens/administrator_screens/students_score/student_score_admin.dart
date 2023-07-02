import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/administrator_screens/students_score/cubit/states.dart';

import '../admin_home/admin_home.dart';
import 'cubit/cubit.dart';
class Data {
  final String studentName;
  final int studentNumber;
  final String studentScore;

  Data({
    required this.studentName,
    required this.studentNumber,
    required this.studentScore,
  });
}

class ExamRes extends StatefulWidget {
  const ExamRes({
    Key? key,
    required this.examName, required this.examPassword
  }) : super(key: key);
  final String examName;
  final String examPassword;
  @override
  State<ExamRes> createState() => _ExamResState();
}

class _ExamResState extends State<ExamRes> {
  List<Data> studentData = [
    Data(
      studentName: 'Shimaa Ahmed',
      studentNumber: 11,
      studentScore: '40 / 80',
    ),
    Data(
      studentName: 'Samar Ali',
      studentNumber: 12,
      studentScore: '50 / 80',
    ),
    Data(
      studentName: 'Rahma Magdi',
      studentNumber: 13,
      studentScore: '60 /80',
    ),
    Data(
      studentName: 'Asmaa Maher',
      studentNumber: 14,
      studentScore: '60 / 80',
    ),
  ];
  Color myColor = const Color.fromRGBO(88, 17, 142, 0.8);
  Color pColor = const Color.fromRGBO(164, 94, 217, 1);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShowStudentsScoreCubit()..getAllAnswers(examName: widget.examName, examPassword: widget.examPassword),
      child: BlocConsumer<ShowStudentsScoreCubit, ShowStudentsScoreStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = ShowStudentsScoreCubit.get(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const AdminHome()));
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: myColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Exams Rseults',
                      style: TextStyle(
                        color: myColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ]),
              ),
              Expanded(
                child: ConditionalBuilder(
                    condition: state is ! GetAllStudentsScoreLoadingState,
                    builder: (context){
                      return ListView.separated(
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                height: 90,
                                decoration: BoxDecoration(
                                    color: pColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 10),
                                          blurRadius: 50,
                                          color: myColor.withOpacity(0.23)),
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                          CircleAvatar(
                                          backgroundColor: Colors.white70,
                                          minRadius: 30.0,
                                          child: CircleAvatar(
                                            radius: 35.0,
                                            //
                                            backgroundImage: NetworkImage(
                                                '${cubit.allAnswers[index]["studentImage"]}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.allAnswers[index]["studentName"],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                            cubit.allAnswers[index]["studentCode"],
                                          style: const TextStyle(
                                            color: Color.fromRGBO(235, 235, 235, 1),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 100,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: const Color.fromRGBO(248, 170, 36, 1)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Score",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              cubit.allAnswers[index]["correctAnswer"].toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: myColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context,index){
                            return SizedBox(height: 20,);
                          },
                          itemCount: cubit.allAnswers.length,
                      );
                    },
                    fallback: (context)=>Center(
                      child: CircularProgressIndicator(
                        color: myColor,
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
    );
  },
),
    );
  }

  // List<Widget> getList() {
  //   List<Widget> child = ShowStudentsScoreCubit().allAnswers
  //       .map(
  //         (item) => Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         padding: const EdgeInsets.all(10.0),
  //         height: 90,
  //         decoration: BoxDecoration(
  //             color: pColor,
  //             borderRadius: const BorderRadius.all(
  //               Radius.circular(10),
  //             ),
  //             boxShadow: [
  //               BoxShadow(
  //                   offset: const Offset(0, 10),
  //                   blurRadius: 50,
  //                   color: myColor.withOpacity(0.23)),
  //             ]),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 const CircleAvatar(
  //                   backgroundColor: Colors.white70,
  //                   minRadius: 30.0,
  //                   child: CircleAvatar(
  //                     radius: 35.0,
  //                     //https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4
  //                     backgroundImage: NetworkImage(
  //                         '${ShowStudentsScoreCubit().allAnswers[item]["image"]}'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   item.studentName,
  //                   style: const TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 Text(
  //                   item.studentNumber.toString(),
  //                   style: const TextStyle(
  //                     color: Color.fromRGBO(235, 235, 235, 1),
  //                     fontSize: 15,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Container(
  //               height: 100,
  //               width: 80,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   color: const Color.fromRGBO(248, 170, 36, 1)),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(6.0),
  //                 child: Column(
  //                   children: [
  //                     const Text(
  //                       "Score",
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     Text(
  //                       item.studentScore,
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         color: myColor,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   )
  //       .toList();
  //   return child;
  // }
}
