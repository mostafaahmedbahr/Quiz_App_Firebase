class TestBankQuestionModel
{
  String? id;
  String? question;
  String? correctAnswer;
  dynamic answers;

  TestBankQuestionModel(
      this.id,
      this.question,
      this.correctAnswer,
      this.answers,
      );

  TestBankQuestionModel.fromJson(Map<String,dynamic>? json){
    id = json!["id"];
    question = json["question"];
    correctAnswer = json["correct_answer"];
    answers = json["answers"];
  }

  Map<String,dynamic> toMap() {
    return {
      "id": id,
      "question": question,
      "correct_answer": correctAnswer,
      "answers": answers,

    };
  }
}