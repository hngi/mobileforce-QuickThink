class QuestionModel {
  String category;

  String difficulty;

  String question;

  String correctAnswer;

  List<String> incorrectAnswers;

  String type;

  QuestionModel({this.category, this.difficulty, this.question, this.type, this.correctAnswer, this.incorrectAnswers});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['type'] = this.type;
    data['difficulty'] = this.difficulty;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['incorrect_answers'] = this.incorrectAnswers;
    return data;
  }
}
