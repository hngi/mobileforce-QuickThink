import 'dart:convert';

import 'package:quickthink/model/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FetchedQuestions {
  int responseCode;
  List<QuestionModel> results;
  String userGameID;

  FetchedQuestions({this.responseCode, this.results});

  void addToLocalStorage(List<QuestionModel> questions) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> questionObjectToString = [];
    for (QuestionModel question in questions) {
      questionObjectToString.add(jsonEncode(question));
    }
    prefs.setStringList('offlineQuestions', questionObjectToString);
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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['response_code'] = this.responseCode;
  //   if (this.results != null) {
  //     data['results'] = this.results.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

  Future<List<QuestionModel>> questionUpdate(
      String gameCode, String userName) async {
    final jsonEndpoint = "https://brainteaserdev.pythonanywhere.com/usergame/play/";
    return await http.post(jsonEndpoint, body: {
      "game_code": gameCode,
      "user_name": userName
    }).then((http.Response res) {
      dynamic response = res.body;
      final int statusCode = res.statusCode;

      if (statusCode == 200) {
        List question = json.decode(response)['data']['questions'];

        userGameID = json.decode(response)['data']['usergameData']['id'];
        //QuestionModel result = QuestionModel.fromJson(question);
        print(question);
        return question
            .map((questions) => new QuestionModel.fromJson(questions))
            .toList()
              ..shuffle();
      } else
        throw Exception(
            'We were not able to successfully download the json data.');
    });
  }

  Future updateScore(String userID) async{
   
    final jsonEndpoint = "https://brainteaserdev.pythonanywhere.com/usergame/score/increment/$userID/";
     await http.post(jsonEndpoint);
  }
}
