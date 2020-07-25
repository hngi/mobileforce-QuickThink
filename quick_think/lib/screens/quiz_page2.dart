import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/bottom_navigation_bar.dart';
import 'package:quickthink/data/FetchedQuestions.dart';
import 'package:quickthink/model/question_model.dart';
import 'package:quickthink/model/question_sorting_model.dart';
import 'package:quickthink/screens/category/services/utils/animations.dart';
import 'package:quickthink/screens/help.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:quickthink/widgets/noInternet.dart';

class QuizPage2 extends StatefulWidget {
  final List<QuestionModel> questionData;
  final String userName;
  final String gameCode;
  final FetchedQuestions model;
  QuizPage2({this.questionData, this.userName, this.gameCode, this.model});
  @override
  _QuizPage2State createState() => _QuizPage2State();
}

class _QuizPage2State extends State<QuizPage2> {
  QuestionFunctions questionFunctions;
  List<QuestionModel> _questionBank;
  bool stopTimer = false;
  String userAnswer;

  //Check Internet Connectivity
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool _connection = false;

  @override
  void initState() {
    //Check Internet Connectivity
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult connectivityResult) {
        _connectionStatus = connectivityResult.toString();
        print(_connectionStatus);
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          if (!mounted) return;
          setState(() {
            //   startTimer();
            _connection = false;
          });
        } else {
          if (!mounted) return;
          setState(() {
            _connection = true;
          });
        }
      },
    );
    _questionBank = widget.questionData;
    questionFunctions = new QuestionFunctions(_questionBank);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return 
    _connection ?NoInternet():
    Scaffold(
        backgroundColor: Color(0xFF1C1046),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        color: Colors.white,
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        onPressed: () => exitAlert(context)),
                  ),
                  _progress(height, width),
                  SizedBox(height: height * 0.05),
                  _box(height, width, heightBox, widthBox),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _box(height, width, heightBox, widthBox) {
    return Container(
      width: width,
      height: heightBox * 1.1,
      padding: EdgeInsets.all(SizeConfig().xMargin(context, 10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: height * 0.015,
          ),
          Flexible(flex: 1, child: _question()),
          SizedBox(
            height: height * 0.07,
          ),
          // Flexible(flex: 1, child: _options()),
          SizedBox(
            height: height * 0.015,
          ),
        ],
      ),
    );
  }

  Widget _question() {
    return FadeIn(
      delay: 0.1,
      child: Text(
        'questionFunctions.getQuestionText()',
        style: GoogleFonts.poppins(
          color: Color(0xFF38208C),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          // fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  exitAlert(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              child: Container(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 12.0, left: 20.0, right: 20.0),
                        child: Text(
                          'You’re leaving the game',
                          style: style.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 12.0, left: 20.0, right: 20.0),
                        child: Text(
                          'Are you sure you want to leave the game? all progress will be lost',
                          style: style.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            actionButton(height, width, 'Yes', context, () {
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .pushReplacementNamed(DashboardScreen.id);
                            }, Color(0xFFFF1F2E)),
                            actionButton(height, width, 'No', context, () {
                              Navigator.pop(context);
                            }, Color(0xFF86EC88)),
                          ],
                        ),
                      )
                    ],
                  )));
        });
  }

  Container actionButton(double height, double width, String text,
      BuildContext context, final onPressed, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: color,
      ),
      height: 48.0,
      // width: .0,
      child: FlatButton(
          child: Text(
            text,
            style: style.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
          onPressed: onPressed),
    );
  }

  Widget _progress(height, width) {
    return Text(
      'Question ' +
          //(questionFunctions.currentQuestion() + 1).toString() +
          ' of ' +
          '',
      // questionFunctions.numberOfQuestions().toString(),
      style: GoogleFonts.poppins(
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  _options() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    List<Widget> option = List();
    bool _isSelected = false;

    for (var i = 0; i < questionFunctions.getOptions().length; i++) {
      //isPicked.add(false);
      option.add(
        InkWell(
          onTap: () {
            // isPicked = [false, false, false, false];
            // setState(() {
            //   _isSelected = !_isSelected;
            //   isPicked[i] = _isSelected;
            //   userAnswer = questionFunctions.getOptions()[i];
            //   print(isPicked);
            // });

            // Timer(Duration(milliseconds: 100), () {
            //   print('getUserPickedAnswer:$userAnswer');

            //   if (userAnswer.isNotEmpty && userAnswer != null) {
            //     checkAnswer(userAnswer);
            //     count++;
            //     isPicked = [false, false, false, false];
            //   }
            // });
          },
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: questionFunctions.colorPickedAnswer()[i]
                    //     ? isCorrect(userAnswer) ? Colors.green : Colors.red
                    //     : Colors.white,
                    border: Border.all(color: Colors.black26)),
                height: heightBox * .128,
                width: widthBox * .77,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      questionFunctions.getOptions()[i],
                      style: GoogleFonts.poppins(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return option;
  }

  bool isCorrect(String userResponse) {
    stopTimer = true;
    bool correct = true;
    String correctAnswer = questionFunctions.getCorrectAnswer();
    if (userResponse == correctAnswer) {
      return correct;
    } else {
      return correct = false;
    }
  }
}

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
    //print('_questionBank1:$_questionBank');
    print('_questionBanknum:${_questionBank[_questionNumber].question}');
    return _questionBank[_questionNumber].question;
  }

  List<String> getOptions() {
    //print((_questionBank[_questionNumber].incorrectAnswers));
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
