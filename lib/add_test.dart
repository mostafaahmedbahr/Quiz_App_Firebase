import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_new/models/exam_model.dart';
import 'package:quiz_app_new/models/exam_model.dart';
import 'package:quiz_app_new/models/question_model.dart';

class AddExamScreen extends StatefulWidget {
  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _examNameController = TextEditingController();
  final _questionsController = TextEditingController();
  List<Question> _questions = [];
  void saveExam(ExamModel exam) {
    FirebaseFirestore.instance.collection('exams').add({
      'name': exam.examName,
      'questions': exam.questions!.map((q) => {
        'text': q.questionName,
        'answers': q.questionAnswers!.map((a) => {
          'text': a.answerText,
          'isCorrect': a.isCorrect,
        }).toList(),
      }).toList(),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _examNameController,
                decoration: InputDecoration(
                  labelText: 'Exam Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the exam name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Questions'),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_questions[index].questionName!),
                    );
                  },
                ),
              ),
              TextFormField(
                controller: _questionsController,
                decoration: InputDecoration(
                  labelText: 'Add Question',
                ),
                onFieldSubmitted: (value) {
                  setState(() {
                    _questions.add(Question(
                      questionName: value,
                      questionAnswers: [],

                    ));
                    _questionsController.clear();
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Save Exam'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ExamModel exam = ExamModel(
                      examName : _examNameController.text,
                      questions: _questions,
                    );
                    saveExam(exam);

                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}