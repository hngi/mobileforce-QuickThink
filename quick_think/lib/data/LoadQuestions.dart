import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quickthink/data/QuestionStorage.dart';

class LoadQuestions{

  QuestionStorage storage = QuestionStorage();

  List levels = ['easy','medium','hard'];

  String url = 'https://opentdb.com/api.php?amount=100&difficulty=';
  String nullList = '';

  void loadQuestions() async{

    for (var level in levels){
      String apiRequest = '$url$level';

      Response data = await get(apiRequest);

      storage.setDifficulty(level);

      if(data.statusCode == 200){
        storage.writeQuestions(data.body);
      }else{
        storage.writeQuestions(nullList);
      }

    }

  }
}