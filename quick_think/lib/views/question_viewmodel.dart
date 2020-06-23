import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:quickthink/data/FetchedQuestions.dart';
import 'package:quickthink/model/question_model.dart';

enum questionGeneratedState{DataFetched,Busy,NoData}

class QuestionViewModel{

  bool hasError = false;
  bool hasData = true;

  final StreamController<questionGeneratedState> _stateController = StreamController<questionGeneratedState>();

  List<QuestionModel> questionResponse;

  Stream<questionGeneratedState> get questionState => _stateController.stream;

  Future getQuestions(apiRequest) async {

    _stateController.add(questionGeneratedState.Busy);
    Response data = await get(apiRequest);

    if(data.statusCode == 200){
      var decodedData = jsonDecode(data.body);

      FetchedQuestions apiResponse = FetchedQuestions.fromJson(decodedData);

      questionResponse = apiResponse.results;
    }else{
      hasError = true;
    }

    if(questionResponse == null){
      hasData = false;
    }

    if(hasError){
     return _stateController.addError("Oops! An error occured while fetching data. Check your connectivity");
    }

    if(!hasData){
      return _stateController.add(questionGeneratedState.NoData);
    }else{
      _stateController.add(questionGeneratedState.DataFetched);
    }
  }
}