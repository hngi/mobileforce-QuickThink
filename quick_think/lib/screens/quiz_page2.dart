import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/bottom_navigation_bar.dart';
import 'package:quickthink/data/FetchedQuestions.dart';
import 'package:quickthink/model/question_ends.dart';
import 'package:quickthink/model/question_model.dart';
import 'package:quickthink/model/question_functions.dart';
import 'package:quickthink/screens/help.dart';
import 'package:quickthink/utils/quizTimer.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:quickthink/widgets/noInternet.dart';
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

class _QuizPage2State extends State<QuizPage2>
    with SingleTickerProviderStateMixin {
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
  List<Color> optionColors = List();
  bool isCorrect;
  int correctOption;

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userName = pref.getString('Username');
    print('widget.userName: ${widget.userName}');
    if (_userName == null) {
      _userName = widget.userName;
    }
  }

  void timerZero() {
    setState(() {
      if (!questionFunctions.isFinished()) {
        resetTimer = true;
        questionFunctions.nextQuestion();
        _controller.forward(from: 0.0);
        _controller.reverse(from: 1.0);
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

  void checkAnswer(String option) {
    String correctAnswer = questionFunctions.getCorrectAnswer();
    questionFunctions.response = option;
    if (!questionFunctions.isFinished()) {
      if (questionFunctions.response == correctAnswer) {
        widget.model.updateScore(widget.model.userGameID);
        questionFunctions.incrementScore();
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
      _controller.reset();
      _controller.forward(from: 0.0);
      _controller.reverse(from: 1.0);
    } else if (questionFunctions.isFinished()) {
      stopTimer = true;
      if (questionFunctions.response == correctAnswer) {
        widget.model.updateScore(widget.model.userGameID);
        isPicked = [false, false, false, false];
        questionFunctions.incrementScore();
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

        IQEnds(
                totalScore: questionFunctions.totalScore,
                username: _userName,
                questionNumber: questionFunctions.numberOfQuestions(),
                message:
                    'You have successfully completed the test proceed for the result',
                gameCode: widget.gameCode)
            .showEndMsg(context);
      }
    }
  }

  Color optionColorFunc(bool isPicked, bool isCorrectAnswer) {
    if (isPicked) {
      if (isCorrectAnswer) {
        optionColor = Color(0xFF86EC88);
      } else {
        optionColor = Color(0xFFFF4D55);
      }
    }
    return optionColor;
  }

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
    questionFunctions = QuestionFunctions(_questionBank);
    getUserName();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(() => setState(() {}));

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInBack,
    ));

    _controller.forward();
    _offsetAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    if (!_controller.isDismissed) {
      _controller.dispose();
    }
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return _connection
        ? NoInternet()
        : Scaffold(
            backgroundColor: Color(0xFF1C1046),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      _box(height, width, heightBox, widthBox)
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _box(height, width, heightBox, widthBox) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: width,
        //margin: EdgeInsets.all(SizeConfig().xMargin(context, 15)),
        //height: heightBox * 1.1,
        padding: EdgeInsets.all(SizeConfig().xMargin(context, 8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig().xMargin(context, 0.5),
            ),
            _question(),
            SizedBox(
              height: SizeConfig().xMargin(context, 0.5),
            ),
            Column(
              children: _options(),
            ),
            SizedBox(
              height: height * 0.015,
            ),
          ],
        ),
      ),
    );
  }

  Widget _question() {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        child: Text(
          questionFunctions.getQuestionText(),
          style: GoogleFonts.poppins(
            color: Color(0xFF38208C),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            // fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.justify,
        ),
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
        callBackFunc: () {
          setState(() {
            timerZero();
          });
        },
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
      optionColors.add(Colors.white);
      if (questionFunctions.getOptions()[i] == questionFunctions.getCorrectAnswer()) {
        correctOption = i;
      }
      option.add(
        InkWell(
          onTap: () {
            setState(() {
              userAnswer = questionFunctions.getOptions()[i];
              userAnswer == questionFunctions.getCorrectAnswer()
                  ? isCorrect = true
                  : isCorrect = false;
              _isSelected = !_isSelected;
              isPicked[i] = _isSelected;
              optionColors[i] = optionColorFunc(isPicked[i], isCorrect);
              if(!isCorrect){
                optionColors[correctOption] =  Color(0xFF86EC88);
              }
             
              Future.delayed(Duration(milliseconds: 700), () {
                
                setState(() {
                  if (userAnswer.isNotEmpty && userAnswer != null) {
                    isPicked = [false, false, false, false];
                    checkAnswer(userAnswer);
                  }
                  optionColors[i] = Colors.white;
                  optionColors[correctOption] = Colors.white;
                });
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
                      color: optionColors[i] ?? Colors.white,
                      border: Border.all(color: Colors.black26)),
                  height: heightBox * .128,
                  width: widthBox * .77,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 3.0),
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
}
