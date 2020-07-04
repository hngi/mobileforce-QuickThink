import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/model/question_sorting_model.dart';

class QuizPage extends StatefulWidget {
  final String difficultyLevel;
  final int numberOfQuestions;
  final int time;
  final String userName;

  QuizPage(
      {Key key,
      @required this.difficultyLevel,
      this.numberOfQuestions,
      this.time,
      @required this.userName});
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _quizMark = 0;
  int _quizDuration = 0;
  int _marks = 0;
  bool _correctAnswer;

  String userResponse;
  String userAnswer;
  String _difficultyLevel;
  String _numberOfQuestion;

  QuickThink _quickThink;

  Timer _quizTimer;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _quizTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_quizDuration < 1) {
            timer.cancel();
          } else {
            _quizDuration = _quizDuration - 1;
            print('the time is $_quizDuration');
          }
        },
      ),
    );
  }


  @override
  void initState() {
    //_quickThink = QuickThink(difficultyLevel: widget.difficultyLevel);
   _numberOfQuestion = widget.numberOfQuestions.toString();

    if (widget.difficultyLevel == 'Easy') {
      _quickThink = QuickThink(difficultyLevel: 'easy');
      setState(() {
        _difficultyLevel = 'easy';
        _quizDuration = 60;
        _quizMark = 1;
      });
    } else if (widget.difficultyLevel == 'Average') {
      _quickThink = QuickThink(difficultyLevel: 'medium');
      setState(() {
        _difficultyLevel = 'medium';
        _quizDuration = 45;
        _quizMark = 2;
      });
    } else if (widget.difficultyLevel == 'Hard') {
      _quickThink = QuickThink(difficultyLevel: 'hard');
      setState(() {
         _difficultyLevel = 'hard';
        _quizDuration = 30;
        _quizMark = 3;
      });
    }
    startTimer();
    super.initState();
  }
  

  int getTotalMarks() {
    for (int i = 0; i <= widget.numberOfQuestions; i++) {
      _correctAnswer ? _marks += _quizMark : _marks = _marks;
    }
    return _marks;
  }

  

  var style = GoogleFonts.poppins(
    color: Color(0xFF1C1046),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return Scaffold(
        backgroundColor: Color(0xFF1C1046),
        body: Stack(
          children: <Widget>[
            _backIcon(height, width),
            _category(height, width),
            _textTitle(height, width),
            _timer(height, width),
            _progress(height, width),
            _quickThink.questionList(_difficultyLevel, _numberOfQuestion)
            //_box(height, width, heightBox, widthBox),
          ],
        ));
  }


  Widget _container(double height, double width) {
    return Positioned(
        top: height * 0.21,
        left: width * .064,
        child: Container(
          width: width * .872,
          color: Color(0xFF18C5D9),
          child: Container(
            width: width * .104,
            color: Color(0xFF574E76),
            height: 5,
          ),
        ));
  }

  Widget _backIcon(height, width) {
    return Positioned(
      top: height * .064,
      left: width * .06,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(
            0xFFFFFFFF,
          ),
        ),
      ),
    );
  }

  Widget _category(height, width) {
    return Positioned(
      top: height * .10,
      left: width * .496,
      child: FlatButton(
        color: Color(0xFF574E76),
        onPressed: () {},
        child: Text(
          widget.difficultyLevel,
          style: GoogleFonts.poppins(
            color: Color(0xFF86EC88),
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _textTitle(height, width) {
    return Positioned(
        top: height * .12,
        left: width * .075,
        child: Text(
          widget.numberOfQuestions.toString() + ' Questions',
          style: GoogleFonts.poppins(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _timer(height, width) {
    return Positioned(
      top: height * .10,
      left: width * .75,
      child: FlatButton(
        color: Color(0xFF574E76),
        onPressed: () {},
        child: Text(
          '00 : ' + _quizDuration.toString().padLeft(2, '0'),
          style: GoogleFonts.poppins(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _progress(height, width) {
    return Positioned(
        top: height * .17,
        left: width * .064,
        child: Text(
          'Question 1 of ' + widget.numberOfQuestions.toString(),
          style: GoogleFonts.poppins(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  
 }
