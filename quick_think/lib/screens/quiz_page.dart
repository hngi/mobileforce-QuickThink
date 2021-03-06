import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/model/question_sorting_model.dart';
import 'package:quickthink/bottom_navigation_bar.dart';

class QuizPage extends StatefulWidget {
  final String gameCode;
  final String userName;
  final int time;

  QuizPage({
    Key key,
    @required this.gameCode,
    @required this.userName,
    this.time,
  });
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
 
  String userResponse;
  String userAnswer;
 

  QuickThink _quickThink;

  // @override
  // void dispose() {
  //   _quizTimer.cancel();
  //   super.dispose();
  // }

  @override
  void initState() {
    _quickThink =
        QuickThink(gameCode: widget.gameCode, userName: widget.userName);

    // _numberOfQuestion = widget.numberOfQuestions.toString();

    // if (widget.difficultyLevel == 'Easy') {
    //   _quickThink = QuickThink(difficultyLevel: 'easy');
    //   setState(() {
    //     _difficultyLevel = 'easy';
    //     _quizDuration = 60;
    //     _quizMark = 1;
    //   });
    // } else if (widget.difficultyLevel == 'Average') {
    //   _quickThink = QuickThink(difficultyLevel: 'medium');
    //   setState(() {
    //     _difficultyLevel = 'medium';
    //     _quizDuration = 45;
    //     _quizMark = 2;
    //   });
    // } else if (widget.difficultyLevel == 'Hard') {
    //   _quickThink = QuickThink(difficultyLevel: 'hard');
    //   setState(() {
    //     _difficultyLevel = 'hard';
    //     _quizDuration = 30;
    //     _quizMark = 3;
    //   });
    // }
    // startTimer();
    super.initState();
  }

  // int getTotalMarks() {
  //   for (int i = 0; i <= widget.numberOfQuestions; i++) {
  //     _correctAnswer ? _marks += _quizMark : _marks = _marks;
  //   }
  //   return _marks;
  // }

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
    return WillPopScope(
    onWillPop: () {
     return exitAlert(context);
    },
    child:Scaffold(
        backgroundColor: Color(0xFF1C1046),
        body: Stack(
          children: <Widget>[
            _backIcon(height, width),
            // _category(height, width),
            // _textTitle(height, width),
            // _timer(height, width),
            //_progress(height, width),
            _quickThink,
            //_box(height, width, heightBox, widthBox),
          ],
        )));
  }

  // Widget _container(double height, double width) {
  //   return Positioned(
  //       top: height * 0.21,
  //       left: width * .064,
  //       child: Container(
  //         width: width * .872,
  //         color: Color(0xFF18C5D9),
  //         child: Container(
  //           width: width * .104,
  //           color: Color(0xFF574E76),
  //           height: 5,
  //         ),
  //       ));
  // }

  Widget _backIcon(height, width) {
    return Positioned(
      top: height * .064,
      left: width * .06,
      child: IconButton(
        onPressed: () {
          exitAlert(context);
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
                        margin: EdgeInsets.only( bottom: 12.0, left: 20.0, right: 20.0),
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
                        margin: EdgeInsets.only(bottom: 12.0, left: 20.0, right: 20.0),
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
                        margin: EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            actionButton(height, width, 'Yes', context,
                                () {
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

  // Widget _category(height, width) {
  //   return Positioned(
  //     top: height * .10,
  //     left: width * .496,
  //     child: FlatButton(
  //       color: Color(0xFF574E76),
  //       onPressed: () {},
  //       child: Text(
  //         widget.difficultyLevel,
  //         style: GoogleFonts.poppins(
  //           color: Color(0xFF86EC88),
  //           fontSize: 16,
  //           fontStyle: FontStyle.normal,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _textTitle(height, width) {
  //   return Positioned(
  //       top: height * .12,
  //       left: width * .075,
  //       child: Text(
  //         widget.numberOfQuestions.toString() + ' Questions',
  //         style: GoogleFonts.poppins(
  //           color: Color(0xFFFFFFFF),
  //           fontSize: 20,
  //           fontStyle: FontStyle.normal,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ));
  // }

  /* Widget _timer(height, width) {
    return Positioned(
      top: height * .10,
      left: width * .75,
      child: FlatButton(
        color: Color(0xFF574E76),
        onPressed: () {},
        child:timerQuiz,
      ),
    );
  } */

}
/*
  Widget _box(height, width, heightBox, widthBox) {
    return Positioned(
        top: height * .28,
        bottom: height * .11,
        left: width * .064,
        right: width * .064,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xFFFFFFFF),
          ),
          child: Stack(
            children: <Widget>[
              _nextButton(height, width, heightBox, widthBox),
              _question(heightBox, widthBox),
              _optionOne(heightBox, widthBox),
              _optionTwo(heightBox, widthBox),
              _optionThree(heightBox, widthBox),
              _optionFour(heightBox, widthBox)
            ],
          ),
        ));
  }

  Widget _optionOne(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .26,
      left: widthBox * .055,
      right: widthBox * .055,
      child: CardOptions(
        title: '1993',
      ),
    );
  }

  Widget _optionTwo(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .408,
      left: widthBox * .055,
      right: widthBox * .055,
      child: CardOptions(
        title: '1452',
      ),
    );
  }

  Widget _optionThree(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .55,
      left: widthBox * .055,
      right: widthBox * .055,
      child: CardOptions(
        title: '1870',
      ),
    );
  }

  Widget _optionFour(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .70,
      left: widthBox * .055,
      right: widthBox * .055,
      child: CardOptions(
        title: '1457',
      ),
    );
  }

  Widget _nextButton(height, width, heightBox, widthBox) {
    return Positioned(
      top: heightBox * .89,
      left: widthBox * .58,
      right: widthBox * .0,
      bottom: heightBox * .0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Color(0xFF18C5D9),
        ),
        height: height * .069,
        width: width * .368,
        child: FlatButton(
          child: Text(
            'Next',
            style: style.copyWith(
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _question(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .076,
      left: widthBox * .11,
      right: widthBox * .13,
      child: Text(
        'When was leonardo da \nvinci born?',
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
}

class CardOptions extends StatefulWidget {
  String title;
  CardOptions({@required this.title});
  @override
  _CardOptionsState createState() => _CardOptionsState();
}

class _CardOptionsState extends State<CardOptions> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            setState(() {
              _selected = !_selected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _selected ? Colors.green : Colors.white,
                border: Border.all(color: Colors.black26)),
            height: heightBox * .128,
            width: widthBox * .77,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(widget.title,
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
*/
