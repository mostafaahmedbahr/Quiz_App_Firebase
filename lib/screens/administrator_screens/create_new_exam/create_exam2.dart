 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:quiz_app_new/core/nav.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/administrator_screens/create_new_exam/cubit/cubit.dart';
import 'package:quiz_app_new/screens/administrator_screens/create_new_exam/cubit/states.dart';

 import 'exam_success.dart';



class CreateExam2 extends StatefulWidget {
  const CreateExam2({Key? key, required this.examName, required this.administratorCode, required this.examPassword,
  required this.examType}) : super(key: key);
  final String examName;
  final String administratorCode;
  final String examPassword;
  final String examType;
  @override
  State<CreateExam2> createState() => _CreateExam2State();
}

class _CreateExam2State extends State<CreateExam2> {

  final questionController = TextEditingController();
  final answerControllers = List.generate(3, (index) => TextEditingController());
  final correctAnswerController = TextEditingController();
  int _nextQuestionId = 1;
  final Color c = const Color.fromRGBO(99, 9, 167, 1);
  final List<Question> questions = [ ];

  void _addFields() {
    setState(() {
      questions.add(Question()..id = _nextQuestionId++);
    });
  }


  @override
  Widget build(BuildContext context) {
    print(widget.examType.toString());
    return BlocConsumer<CreateNewExamCubit,CreateNewExamStates>(
      listener: (context,state){
        if(state is AddNewExamSuccessState){
          AppNav.customNavigator(
              context: context,
              screen: SuccesExam(),
              finish: true,
          );
        }
      },
      builder:  (context,state){
        var cubit = CreateNewExamCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: myColor,
            title:buildText('Add Questions', 25),
          ),
          body: Container(
            margin: const EdgeInsets.all(10),
            color: const Color.fromRGBO(241, 241, 241, 1),
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return QuestionWidget(
                      question: questions[index],
                      onAnswerChanged: (answers) {
                        setState(() {
                          questions[index].answers = answers;
                        });
                      },
                      onCorrectAnswerChanged: (correctAnswer) {
                        setState(() {
                          questions[index].correctAnswer = correctAnswer;
                        });
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildElevatedButton('Add More Questions', _addFields),
                      ConditionalBuilder(
                        condition: state is ! AddNewExamLoadingState,
                        fallback: (context)=>Center(
                          child: CircularProgressIndicator(
                            color: myColor,
                          ),
                        ),
                        builder: (context){
                          return buildElevatedButton('Finish', () async {
                          cubit.addExamToFirebase(
                            examType: widget.examType.toString(),
                              examName: widget.examName,
                              administratorCode: widget.administratorCode,
                              examPassword: widget.examPassword,
                              questions: questions,
                          );
                          print(questions[0].question);
                          print(questions[0].answers);
                          print(questions[0].correctAnswer);
                          print(questions[0].id);
                          // cubit.addNewExam(
                          //   examPassword: examPassword,
                          //   examName: examName,
                          //   adminCode: ,
                          //   id: ,
                          //   answers: ,
                          //   correctAnswers: ,
                          //   questions: questions,
                          // );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SuccesExam()),
                          // );
                        });
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
     
    );
  }

  Widget buildText(String str, double fontSize,
      {TextAlign alignment = TextAlign.center}) {
    // final color = const Color(0xFF6309A7);
    final style = TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    return Text(
      str,
      style: style,
      textAlign: alignment,
    );
  }

  ElevatedButton buildElevatedButton(String str, Function fun) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(50, 50),
          backgroundColor: const Color.fromRGBO(164, 94, 217, 1),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: fun as void Function()?,
      child: Text(
        str,
        style: const TextStyle(
            fontSize: 20, color: Color.fromRGBO(241, 241, 241, 1)),
      ),
    );
  }
}

class Question {
  int id = 0;
  String question = '';
  List<String> answers = List.generate(3, (_) => '');
  String correctAnswer = '';
}
class QuestionWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<List<String>> onAnswerChanged;
  final ValueChanged<String> onCorrectAnswerChanged;


  const QuestionWidget({
    Key? key,
    required this.question,
    required this.onAnswerChanged,
    required this.onCorrectAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        buildText('Question ${question.id}', 20),
        buildTextFormField(
          question.question,
          'Enter Question',
              (value) {
            question.question = value;
          },
        ),
        const SizedBox(height: 20),

        buildText('Expected Answers', 20),
        Column(
          children: List.generate(
            question.answers.length,
                (index) => buildTextFormField(
              question.answers[index],
              'Expected Answer ${index + 1}',
                  (  value) {
                print(value);
                question.answers[index] = value;
                print(question.answers[index]);
                // onAnswerChanged(value);
              },
            ) ,
          ),
        ),
        const SizedBox(height: 20),
        ListTile(
          title: buildText('Correct Answer', 20),
          subtitle: buildTextFormField(
            question.correctAnswer,
            'Enter Correct Answer',
                (value) {
              onCorrectAnswerChanged(value);
            },
          ),
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.grey),
      ],
    );
  }

  Padding buildTextFormField(
      String initialValue, String hintText, ValueChanged<String> onChanged, ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          hoverColor: const Color.fromRGBO(164, 94, 217, 1),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromRGBO(164, 94, 217, 1)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
            BorderSide(color: Color.fromRGBO(164, 94, 217, 1), width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
            BorderSide(color: Color.fromRGBO(99, 9, 167, 1), width: 2),
          ),
        ),
      ),
    );
  }

  Widget buildText(String str, double fontSize,
      {TextAlign alignment = TextAlign.center}) {
    final color = const Color(0xFF6309A7);
    final style = TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    return Text(
      str,
      style: style,
      textAlign: alignment,
    );
  }
}