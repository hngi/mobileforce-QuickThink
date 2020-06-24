import 'package:hive/hive.dart';

//  part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel {
  @HiveField(0)
  String category;
  @HiveField(1)
  String difficulty;
  @HiveField(2)
  String question;
  @HiveField(3)
  String correctAnswer;
  @HiveField(4)
  List<String> incorrectAnswers;
  @HiveField(5)
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