import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/student_profile/cubit/states.dart';

import '../../conctant.dart';
import '../../core/toast/toast.dart';
import 'cubit/cubit.dart';

class StudentAnswersReviewScreen extends StatefulWidget {
  const StudentAnswersReviewScreen({Key? key}) : super(key: key);

  @override
  State<StudentAnswersReviewScreen> createState() => _StudentAnswersReviewScreenState();
}

class _StudentAnswersReviewScreenState extends State<StudentAnswersReviewScreen> {

  List<dynamic> selectedOption = [];
  @override
  void initState() {
    StudentProfileCubit.get(context).getAllAnswers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentProfileCubit, StudentProfileStates>(
  listener: (context, state) {},
  builder: (context, state) {
    print(selectedOption);
    var cubit = StudentProfileCubit.get(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: myColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Show Your Answers',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kPrimartColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ConditionalBuilder(
                    condition: state is ! GetAllStudentsScoreLoadingState,
                    fallback: (context)=>Center(
                      child: CircularProgressIndicator(
                        color: myColor,
                      ),
                    ),
                    builder: (context){
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (selectedOption.length <= index) {
                            selectedOption.add(-1);
                          }
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              width: 335,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Question ${index + 1}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color.fromRGBO(253, 190, 82, 1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cubit.allStudentAnswers[0]["questions"][index]["question"],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        color:kPrimartColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    children: [
                                      RadioListTile(
                                        activeColor: Colors.black87,
                                        title: Text(
                                          cubit.allStudentAnswers[0]["questions"][index]["answers"][0],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color: cubit.allStudentAnswers[0]["questions"][index]["answers"][0] == cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["studentAnswers"][index] == cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]
                                                ? Colors.green // selected option is correct
                                                :cubit.allStudentAnswers[0]["questions"][index]["answers"][0] == cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["studentAnswers"][index] != cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]
                                                ? Colors.red // selected option is incorrect
                                                : cubit.allStudentAnswers[0]["questions"][index]["answers"][0] != cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["questions"][index]["answers"][0] == cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"] ?
                                            Colors.green : Colors.grey, // no option selected
                                          ),
                                        ),
                                        value: cubit.allStudentAnswers[0]["questions"][index]["answers"][0],
                                        groupValue: selectedOption[index],
                                        onChanged: null,
                                      ),
                                      RadioListTile(
                                        activeColor: Colors.black87,
                                        title: Text(
                                          cubit.allStudentAnswers[0]["questions"][index]["answers"][1],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color:cubit.allStudentAnswers[0]["questions"][index]["answers"][1] == cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["studentAnswers"][index] == cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]
                                                ? Colors.green // selected option is correct
                                                :cubit.allStudentAnswers[0]["questions"][index]["answers"][1] == cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["studentAnswers"][index] != cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]
                                                ? Colors.red // selected option is incorrect
                                                : cubit.allStudentAnswers[0]["questions"][index]["answers"][1] != cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["questions"][index]["answers"][1] == cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"] ?
                                            Colors.green : Colors.grey,// no option selected
                                          ),
                                        ),
                                        value: cubit.allStudentAnswers[0]["questions"][index]["answers"][1],
                                        groupValue: selectedOption[index],
                                        onChanged: null,
                                      ),
                                      RadioListTile(
                                        activeColor: Colors.black87,
                                        title: Text(
                                          cubit.allStudentAnswers[0]["questions"][index]["answers"][2],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color: cubit.allStudentAnswers[0]["questions"][index]["answers"][2] == cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["studentAnswers"][index] == cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]
                                                ? Colors.green // selected option is correct
                                                :cubit.allStudentAnswers[0]["questions"][index]["answers"][2] == cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["studentAnswers"][index] != cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]
                                                ? Colors.red // selected option is incorrect
                                                : cubit.allStudentAnswers[0]["questions"][index]["answers"][2] != cubit.allStudentAnswers[0]["studentAnswers"][index]&&
                                                cubit.allStudentAnswers[0]["questions"][index]["answers"][2] == cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"] ?
                                            Colors.green : Colors.grey,  // no option selected
                                          ),
                                        ),
                                        value: cubit.allStudentAnswers[0]["questions"][index]["answers"][2],
                                        groupValue: selectedOption[index],
                                        onChanged: null,
                                      ),


                                      // RadioListTile(
                                      //   activeColor:   Colors.black87,
                                      //   title: Text(
                                      //     cubit.allStudentAnswers[0]["questions"][index]["answers"][2],
                                      //     style: TextStyle(
                                      //       fontFamily: 'Poppins',
                                      //       // fontWeight: FontWeight.bold,
                                      //       fontSize: 16,
                                      //       color:
                                      //       cubit.allStudentAnswers[0]["questions"][index]["answers"][2] == cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]
                                      //           ? Colors.green // selected option is correct
                                      //           : cubit.allStudentAnswers[0]["studentAnswers"][index]==cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]
                                      //           ? Colors.green // no option selected
                                      //           :
                                      //       cubit.allStudentAnswers[0]["studentAnswers"][index]!=cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"] ?
                                      //       Colors.grey : Colors.red,
                                      //       // cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"] ==
                                      //       //     cubit.allStudentAnswers[0]["questions"][index]["answers"][2]
                                      //       //     ? Colors.green
                                      //       //     : Colors.grey,
                                      //       // cubit.allStudentAnswers[0]["questions"][index]["correctAnswer"]==
                                      //       //     cubit.allStudentAnswers[0]["questions"][index]["answers"][2]?
                                      //       // Colors.green  : Colors.grey ,
                                      //     ),
                                      //   ),
                                      //   value: cubit.allStudentAnswers[0]["questions"][index]["answers"][2],
                                      //   groupValue: selectedOption[index],
                                      //   onChanged:null,
                                      // ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount:cubit.allStudentAnswers[0]["questions"].length,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }
}
