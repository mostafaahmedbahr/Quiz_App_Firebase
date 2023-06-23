import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
 import '../../conctant.dart';
import 'quiz_page.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Examas extends StatefulWidget {
  const Examas({Key? key}) : super(key: key);

  @override
  State<Examas> createState() => _ExamasState();
}

class _ExamasState extends State<Examas> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>StudentQuizCubit()..getAllQuiz(),
      child: BlocConsumer<StudentQuizCubit, StudentQuizStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = StudentQuizCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: myColor,
        ),
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 85),
            const Text(
              'Select your Wanted\nExams',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(99, 9, 167, 1),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 85),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MidtermPage()),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 151,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'asset/image/exam.png',
                            width: 50,
                            height: 52,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Midterm',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(164, 94, 217, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 35),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>const FinalPage()),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 151,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'asset/image/exam.png',
                            width: 50,
                            height: 52,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Final',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(164, 94, 217, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              child: Container(
                width: 150,
                height: 151,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'asset/image/exam.png',
                      width:50,
                      height: 52,
                      fit: BoxFit.contain,
                    ),
                    const  SizedBox(height: 10),
                    const  Text(
                      'Quizzes',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(164, 94, 217, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]
        ),
      );
  },
),
    );
  }
}

class MidtermPage extends StatelessWidget {
  const MidtermPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextColor,
        title: const Text('Midterm Exam'),
      ),
      body: const Center(
        child: Text(
          'This is the Midterm Exam page',
          style: TextStyle(
            fontSize: 24,
            color: kPrimartColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextColor,
        title: const Text('Final Exam'),
      ),
      body: const Center(
        child: Text(
          'This is the Final Exam page',
          style: TextStyle(
            fontSize: 24,
            color: kPrimartColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

