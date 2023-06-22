class QuestionModel {
  String? questionName;
  List<String>? questionAnswers;
  int? questionId;
  String? questionCorrectAnswer;

  QuestionModel({
      this.questionName,
      this.questionAnswers,
      this.questionCorrectAnswer,
      this.questionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'questionName': questionName,
      'questionAnswers': questionAnswers,
      'questionCorrectAnswer': questionCorrectAnswer,
      'questionId': questionId,
    };
  }
}