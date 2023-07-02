import 'package:flutter/material.dart';
import 'package:quiz_app_new/core/nav.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/layout/nav_bar.dart';
import 'package:quiz_app_new/screens/student_quiz/examas.dart';
import '../../conctant.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int correctAnswers;
  final int totalQuestions;

  ScorePage({
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: myColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 85),
            Text(
              'Quiz Result',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color:kPrimartColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(

              score > (totalQuestions / 2)
                        ? 'asset/image/exams.png'
                        : 'asset/image/felid.png',
                    width: 343,
                    height: 231,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Your Score Is: \n$correctAnswers / $totalQuestions ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                      color: Color.fromRGBO(99, 9, 167, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                    AppNav.customNavigator(
                        context: context,
                        screen: Layout(),
                        finish: true,
                    );
                    },

                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kTextColor ,
                      padding: EdgeInsets.symmetric(
                          horizontal: 120, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  if (score < (totalQuestions / 2))
                    Text(
                      'You need to study more to improve your performance next time.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: kTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}










