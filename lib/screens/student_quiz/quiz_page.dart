import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:quiz_app_new/core/nav.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/student_home/cubit/cubit.dart';
import 'package:quiz_app_new/screens/student_quiz/cubit/states.dart';
 import '../../conctant.dart';
 import '../../models/exam_model.dart';
import 'score.dart';
import 'cubit/cubit.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int _seconds = 6000000;
  int? _endTime;

  void _startTimer() {
    _endTime = DateTime.now().millisecondsSinceEpoch + _seconds * 1000;
    setState(() {});
  }
  int questionNumber = 1;
  int _currentQuestionIndex = 0;
  // List<String> questions = [
  //   'Which feature of OOP indicates code reusability?',
  //   'What is the correct way to declare a variable in Dart?',
  //   'Where is the memory allocated for the objects?',
  //   'Which access specifier is usually used for data members of a class?'
  // ];
  // List<List<String>> options = [
  //   ['Encapsulation', 'Inheritance', 'polymorphism', 'Abstraction'],
  //   ['int x = 10;', 'var x = 10;', 'String x = 10;', 'x = 10;'],
  //   [
  //     'HDD',
  //     'ROM',
  //     'RAM',
  //     'Cache'
  //   ],
  //   [
  //     'Default',
  //     'Private',
  //     'Public',
  //     'Protected'
  //   ]
  // ];
  List<dynamic> selectedOption = [];
  @override
  void initState() {
    _startTimer();
    super.initState();
  }
  final List<Question> studentAnswers = [ ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>StudentQuizCubit()..getAllQuiz(),
      child: BlocConsumer<StudentQuizCubit, StudentQuizStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = StudentQuizCubit.get(context);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: myColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20,right: 20),
              child: CountdownTimer(
                endTime: _endTime,
                onEnd: () {
                  // عند انتهاء المؤقت، اذهب إلى الشاشة التالية
                  AppNav.customNavigator(
                    context: context,
                    screen: ScorePage(
                      score: cubit.score,
                      correctAnswers: cubit.score,
                      totalQuestions: cubit.allQuiz[0]["questions"].length,
                    ),
                    finish: true,
                  );
                },
              ),
            ),
          ],
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
                      'Start Your Quiz',
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
                      condition: state is ! GetAllQuizLoadingState,
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
                                        cubit.allQuiz[0]["questions"][index]["question"],
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
                                          activeColor:kTextColor ,
                                          title: Text(
                                            cubit.allQuiz[0]["questions"][index]["answers"][0],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: kTextColor,
                                            ),
                                          ),
                                          value: cubit.allQuiz[0]["questions"][index]["answers"][0],
                                          groupValue: selectedOption[index],
                                          onChanged: (value) {
                                            setState(() {
                                              // studentAnswers[0].questionAnswers!.add(value);
                                              selectedOption[index] = value!;
                                              if(value==cubit.allQuiz[0]["questions"][index]["correctAnswer"]){
                                                cubit.score++;
                                              };
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          activeColor: kTextColor,
                                          title: Text(
                                            cubit.allQuiz[0]["questions"][index]["answers"][1],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              //   fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: kTextColor,
                                            ),
                                          ),
                                          value: cubit.allQuiz[0]["questions"][index]["answers"][1],
                                          groupValue: selectedOption[index],
                                          onChanged: (value) {
                                            setState(() {
                                              // studentAnswers[0].questionAnswers!.add(value);
                                              selectedOption[index] = value!;
                                              if(value==cubit.allQuiz[0]["questions"][index]["correctAnswer"]){
                                                cubit.score++;
                                              };
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          activeColor: kTextColor,
                                          title: Text(
                                            cubit.allQuiz[0]["questions"][index]["answers"][2],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: kTextColor,
                                            ),
                                          ),
                                          value: cubit.allQuiz[0]["questions"][index]["answers"][2],
                                          groupValue: selectedOption[index],
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption[index] = value!;
                                              if(value==cubit.allQuiz[0]["questions"][index]["correctAnswer"]){
                                                cubit.score++;
                                              };
                                              // studentAnswers[0].questionAnswers!.add(value);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount:cubit.allQuiz[0]["questions"].length,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            print(selectedOption);
                            print(cubit.allQuiz[0]["questions"]);
                            print(cubit.score);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('be careful'),
                                    content: Text('Please answer all the questions.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          print(cubit.score);
                                          print(StudentHomeCubit.get(context).studentProfileModel!.name);
                                          cubit.storeStudentScore(
                                            studentAnswers: selectedOption,
                                            questions: cubit.allQuiz[0]["questions"],
                                            studentName:  StudentHomeCubit.get(context).studentProfileModel!.name!=null ?
                                            "${StudentHomeCubit.get(context).studentProfileModel!.name}" :
                                            'Shimaa Ahmed',
                                            studentCode: StudentHomeCubit.get(context).studentProfileModel!.grade!=null ?
                                            "${StudentHomeCubit.get(context).studentProfileModel!.grade}" :
                                            '150177',
                                            studentImage: StudentHomeCubit.get(context).studentProfileModel!.image!=null ?
                                            "${StudentHomeCubit.get(context).studentProfileModel!.image}" :
                                            '',
                                            examName: cubit.allQuiz[0]["examName"],
                                            examPassword: cubit.allQuiz[0]["examPassword"],
                                            administratorCode: cubit.allQuiz[0]["administratorCode"],
                                            correctAnswers: cubit.score,
                                           totalQuestions: cubit.allQuiz[0]["questions"].length,
                                          );
                                          AppNav.customNavigator(
                                              context: context,
                                              screen: ScorePage(
                                                  score: cubit.score,
                                                  correctAnswers: cubit.score,
                                                  totalQuestions: cubit.allQuiz[0]["questions"].length,
                                              ),
                                              finish: true,
                                          );
                                        },
                                        child: Text('OK',style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor,

                                  ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kTextColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  },
),
    );
  }
}



