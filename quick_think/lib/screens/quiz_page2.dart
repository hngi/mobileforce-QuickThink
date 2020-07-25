import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/bottom_navigation_bar.dart';
import 'package:quickthink/data/FetchedQuestions.dart';
import 'package:quickthink/model/question_ends.dart';
import 'package:quickthink/model/question_model.dart';
import 'package:quickthink/model/question_functions.dart';
import 'package:quickthink/screens/category/services/utils/animations.dart';
import 'package:quickthink/screens/help.dart';
import 'package:quickthink/utils/quizTimer.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool resetTimer = false;
  String userAnswer;
  int count = 0;
  List<bool> isPicked = [false, false, false, false];
  String _userName;
  bool correct = true;
  Color optionColor;

  getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userName = pref.getString('Username');
    if (_userName == null) {
      _userName = widget.userName;
    }
  }

  @override
  void initState() {
    _questionBank = widget.questionData;
    questionFunctions = QuestionFunctions(_questionBank);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return Scaffold(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _progress(height, width),
                      _timer(),
                    ],
                  ),
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
          Flexible(
            flex: 5,
            child: Column(
              children: _options(),
            ),
          ),
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
        questionFunctions.getQuestionText(),
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

  Widget _timer() {
    return FlatButton(
      color: Color(0xFF574E76),
      onPressed: () {},
      child: TimerQuiz(
        endQ: stopTimer,
        nextQ: resetTimer,
        callBackFunc: (){}/*timerZero () {
          setState(() {
            timerZero();
          });
        } */,
      ),
    );
  }

  Widget _progress(height, width) {
    return Text(
      'Question ' +
          (questionFunctions.currentQuestion() + 1).toString() +
          ' of ' +
          questionFunctions.numberOfQuestions().toString(),
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
          onTap: () async {
            // isPicked = [false, false, false, false];
            Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                // isCorrect(userAnswer) ? optionColor = Color(0xFF86EC88) : optionColor = Color(0xFFFF4D55);
                _isSelected = !_isSelected;
                isPicked[i] = _isSelected;
                userAnswer = questionFunctions.getOptions()[i];
                // print(isPicked);
                if (userAnswer.isNotEmpty && userAnswer != null) {
                  checkAnswer(userAnswer);
                  count++;
                  isPicked = [false, false, false, false];
                }
                optionColor = Colors.white;
              });
            });
          },
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: optionColor,
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
              ),
            ],
          ),
        ),
      );
    }

    return option;
  }

  bool isCorrect(String userResponse) {
    // stopTimer = true;
    String correctAnswer = questionFunctions.getCorrectAnswer();
    if (userResponse == correctAnswer) {
      return correct;
    } else {
      return !correct;
    }
  }

  void checkAnswer(String option) {
    String correctAnswer = questionFunctions.getCorrectAnswer();
    questionFunctions.response = option;
    if (!questionFunctions.isFinished()) {
      if (questionFunctions.response == correctAnswer) {
        widget.model.updateScore(widget.model.userGameID);
        isPicked = [false, false, false, false];
        resetTimer = true;
        questionFunctions.nextQuestion();
        // resetTimer = false;
      } else {
        isPicked = [false, false, false, false];
        resetTimer = true;
        questionFunctions.nextQuestion();
        // resetTimer = false;
      }
    } else if (questionFunctions.isFinished()) {
      resetTimer = false;
      if (questionFunctions.response == correctAnswer) {
        
        stopTimer = true;
        widget.model.updateScore(widget.model.userGameID);
        isPicked = [false, false, false, false];
        stopTimer = false;
        // stopTimer
        IQEnds(
                totalScore: questionFunctions.totalScore,
                username: _userName,
                questionNumber: questionFunctions.numberOfQuestions(),
                message:
                    'You have successfully completed the test proceed for the result',
                gameCode: widget.gameCode)
            .showEndMsg(context);
      } else {
        isPicked = [false, false, false, false];
        stopTimer = true;
        IQEnds(
                totalScore: questionFunctions.totalScore,
                username: _userName,
                questionNumber: questionFunctions.numberOfQuestions(),
                message:
                    'You have successfully completed the test proceed for the result',
                gameCode: widget.gameCode)
            .showEndMsg(context);
        stopTimer = false;
      }
    }
    
    
  }

  void timerZero() {
   setState(() {
      if (questionFunctions.isFinished()) {
      resetTimer = true;
      questionFunctions.nextQuestion();
    } else if (questionFunctions.isFinished()) {
      stopTimer = true;
      IQEnds(
              totalScore: questionFunctions.totalScore,
              username: _userName,
              questionNumber: questionFunctions.numberOfQuestions(),
              message:
                  'Oops! You have run out of time, proceed to your result.',
              gameCode: widget.gameCode)
          .showEndMsg(context);
    }
   });
  }
}
