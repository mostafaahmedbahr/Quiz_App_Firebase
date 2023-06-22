class ExamModel {
  String? id;
  String? examName;
  String? adminCode;
  String? examPassword;
  List<Question>? questions;

  ExamModel({this.id, this.examName, this.questions});
}

class Question {
  String? questionId;
  String? questionName;
  List<Answer>? questionAnswers;

  Question({this.questionName, this.questionId, this.questionAnswers});
}

class Answer {
  String? answerId;
  String? answerText;
  bool? isCorrect;

  Answer({this.answerId, this.answerText, this.isCorrect});
}