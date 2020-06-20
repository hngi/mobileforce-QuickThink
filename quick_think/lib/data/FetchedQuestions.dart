import 'package:hive/hive.dart';
import 'package:quickthink/model/question_model.dart';

class FetchedQuestions {
  int responseCode;
  List<QuestionModel> results;

  FetchedQuestions({this.responseCode, this.results});

  Box<QuestionModel> questionsBox = Hive.box('offlineQuestions');

  void addToLocalStorage(List<QuestionModel> questions) async {
    await questionsBox.clear();
    await questionsBox.addAll(questions);
  }

  FetchedQuestions.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = new List<QuestionModel>();
      json['results'].forEach((v) {
        results.add(new QuestionModel.fromJson(v));
      });
      addToLocalStorage(results);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}