import 'package:quickthink/model/question_model.dart';

class QuestionFunctions {
  int _correctResponse = 0;
  int _wrongResponse = 0;
  int _questionNumber = 0;
  String response = "";
  int totalQuestions = 0;
  int _totalScore = 0;
  List<QuestionModel> _questionBank;
  String userResponse;
  String userPickedAnswer;
  bool resetTimer = false;
  bool stopTimer = false;

  int count = 0;

  List<bool> isPicked = [false, false, false, false];

  QuestionFunctions(List<QuestionModel> questionBank) {
    _questionBank = questionBank;
    //_questionNumber = _questionBank.length;
    //print('_questionBank:$_questionBank');
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    //  print('questiontext from function');
    return _questionBank[_questionNumber].question;
  }

  List<String> getOptions() {
  
    List options = _questionBank[_questionNumber].incorrectAnswers;
    print(options);
    return options;
  }

  String getCorrectAnswer() {
    print(_questionBank[_questionNumber].correctAnswer);
    return _questionBank[_questionNumber].correctAnswer;
  }

  bool isFinished() {
    print(_questionBank.length);

    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
    _correctResponse = 0;
    _wrongResponse = 0;
    resetTimer = false;
    stopTimer = false;
  }

  int numberOfQuestions() {
    return totalQuestions = _questionBank.length;
  }

  int currentQuestion() {
    return _questionNumber;
  }

  void incrementScore() {
    _correctResponse += 1;
  }

  void decrementScore() {
    _wrongResponse += 1;
  }

  get correctResponse {
    return _correctResponse;
  }

  get wrongResponse {
    return _wrongResponse;
  }

  get totalScore {
    int total = correctResponse;
    return _totalScore = total;
  }

  List<bool> colorPickedAnswer() {
    return isPicked;
  }

  get getColorPickedAnswer {
    return isPicked;
  }

  void timeOutTimer() {}
}