import 'package:flutter/material.dart';
 import 'conctant.dart';
import 'score.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionNumber = 1;
  int _currentQuestionIndex = 0;
  List<String> questions = [
    'Which feature of OOP indicates code reusability?',
    'What is the correct way to declare a variable in Dart?',
    'Where is the memory allocated for the objects?',
    'Which access specifier is usually used for data members of a class?'
  ];
  List<List<String>> options = [
    ['Encapsulation', 'Inheritance', 'polymorphism', 'Abstraction'],
    ['int x = 10;', 'var x = 10;', 'String x = 10;', 'x = 10;'],
    [
      'HDD',
      'ROM',
      'RAM',
      'Cache'
    ],
    [
      'Default',
      'Private',
      'Public',
      'Protected'
    ]
  ];
  List<int> selectedOption = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: kTextColor,
                size: 20,
              ),
            ),
          ),
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
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: questions.length,
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
                                  questions[index],
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
                                      options[index][0],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: kTextColor,
                                      ),
                                    ),
                                    value: 0,
                                    groupValue: selectedOption[index],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption[index] = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    activeColor: kTextColor,
                                    title: Text(
                                      options[index][1],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                     //   fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: kTextColor,
                                      ),
                                    ),
                                    value: 1,
                                    groupValue: selectedOption[index],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption[index] = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    activeColor: kTextColor,
                                    title: Text(
                                      options[index][2],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                       // fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: kTextColor,
                                      ),
                                    ),
                                    value: 2,
                                    groupValue: selectedOption[index],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption[index] = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    activeColor: kTextColor,
                                    title: Text(
                                      options[index][3],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                       // fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: kTextColor,
                                      ),
                                    ),
                                    value: 3,
                                    groupValue: selectedOption[index],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption[index] = value!;
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
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          int correctAnswers = 0;
                          bool isAllQuestionsAnswered = true;
                          for (int i = 0; i < questions.length; i++) {
                            if (selectedOption[i] == -1) { //
                              isAllQuestionsAnswered = false;
                              break;
                            }
                            if (selectedOption[i] == options[i].indexOf('polymorphism') ||
                                selectedOption[i] == options[i].indexOf('var x = 10;') ||
                                selectedOption[i] == options[i].indexOf('RAM') ||
                                selectedOption[i] == options[i].indexOf('Private')) {
                              correctAnswers++;
                            }
                          }
                          if (isAllQuestionsAnswered) {
                            int score = (correctAnswers / questions.length * 100).round();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScorePage(
                                score: score,
                                correctAnswers: correctAnswers,
                                totalQuestions: questions.length,
                              )),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('be careful'),
                                  content: Text('Please answer all the questions.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                          }
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
                          primary:kTextColor,
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
  }
}



