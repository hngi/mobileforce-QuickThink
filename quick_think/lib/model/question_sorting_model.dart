import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/data/FetchedQuestions.dart';
import 'package:quickthink/model/question_ends.dart';
import 'package:quickthink/model/question_model.dart';

class QuickThink {
  String response = "";
  int totalQuestions = 0;

  final int questionNumber;
  final String difficultyLevel;
  FetchedQuestions _fetchedQuestions = new FetchedQuestions();

  QuestionModel questions = QuestionModel();

  QuickThink({this.questionNumber, @required this.difficultyLevel}) {
    //apiQuestion();
    // _questionBank = questionList(
    //   difficultyLevel,
    // ); //iqQuestionBank.iqQuestions(10);
    // //totalQuestions = _questionBank.length;
    // print(_questionBank);
    // for (int i = 0; i < questionNumber; i++) {

    //   //_questionBank[i].correctAnswer;
    // }
  }

  Widget questionList(
      String difficultyLevel, String numberOfQuestions /*, String time*/) {
    var data =
        _fetchedQuestions.questionUpdate(difficultyLevel, numberOfQuestions);
    print(data);
    return FutureBuilder<List<QuestionModel>>(
        future: _fetchedQuestions.questionUpdate(
            difficultyLevel, numberOfQuestions),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          print('SnapShot: ${snapshot.data}');
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            print('SnapShot1: ${snapshot.data}');
            List<QuestionModel> questionData = snapshot.dat

            return new CustomQuestionView(
                questionData: questionData, difficultyLevel: difficultyLevel);
          }

          return new Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ));
        });
  }

  // get player {
  //   return username;
  // }
}

class CustomQuestionView extends StatefulWidget {
  final List<QuestionModel> questionData;
  final String difficultyLevel;

  CustomQuestionView({this.questionData, this.difficultyLevel});

  @override
  _CustomQuestionViewState createState() => _CustomQuestionViewState();
}

class _CustomQuestionViewState extends State<CustomQuestionView> {
  QuickThink quickThink;

  String userAnswer;
  double _correctResponse = 0.0;
  double _wrongResponse = 0.0;
  int _questionNumber = 0;
  String response = "";
  int totalQuestions = 0;
  double _totalScore = 150.0;
  List<QuestionModel> _questionBank;
  String userResponse;

  //final int questionNumber;
  //final String difficultyLevel;

  var style = GoogleFonts.poppins(
    color: Color(0xFF1C1046),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    _questionBank = widget.questionData;
    print('_questionBank $_questionBank');
    //quickThink = QuickThink(difficultyLevel: widget.difficultyLevel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return _box(height, width, heightBox, widthBox);
    //Container();
  }

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
              _question(heightBox, widthBox),
              _optionOne(heightBox, widthBox),
              _optionTwo(heightBox, widthBox),
              _optionThree(heightBox, widthBox),
              _optionFour(heightBox, widthBox),
              _nextButton(height, width, heightBox, widthBox),
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
        title: getOptions()[0],
        onTap: () {
          setState(() {
            userAnswer = getOptions()[0];
          });
        },
      ),
    );
  }

  Widget _optionTwo(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .408,
      left: widthBox * .055,
      right: widthBox * .055,
      child: CardOptions(
        title: getOptions()[1],
        onTap: () {
          setState(() {
            userAnswer = getOptions()[1];
          });
        },
      ),
    );
  }

  Widget _optionThree(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .55,
      left: widthBox * .055,
      right: widthBox * .055,
      child: CardOptions(
        title: getOptions()[2],
        onTap: () {
          setState(() {
            userAnswer = getOptions()[2];
          });
        },
      ),
    );
  }

  Widget _optionFour(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .70,
      left: widthBox * .055,
      right: widthBox * .055,
      child: CardOptions(
        title: getOptions()[3],
        onTap: () {
          setState(() {
            userAnswer = getOptions()[3];
          });
        },
        selected: true,
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
          onPressed: () {
            if (userAnswer.isNotEmpty && userAnswer != null) {
              checkAnswer(userAnswer);
            }
          },
        ),
      ),
    );
  }

  void checkAnswer(String option) {
    String correctAnswer = getCorrectAnswer();

    setState(() {
      userResponse = option;

      if (userResponse == correctAnswer) {
        incrementScore();
        if (isFinished() == true) {
//        Navigator.sth to the results page
//      Throw an alert to the user that evaluation has finished
          IQEnds(
            totalScore: totalScore,
            username: 'widget.userName',
          ).showEndMsg(context);

          reset();
        }
        nextQuestion();
      } else {
        decrementScore();

        if (isFinished() == true) {
//        Navigator.sth to the results page
//      Throw an alert to the user that evaluation has finished
          IQEnds(
            totalScore: totalScore,
            username: 'widget.userName',
          ).showEndMsg(context);

          reset();
        }
        nextQuestion();
      }
    });
  }

  Widget _question(heightBox, widthBox) {
    return Positioned(
      top: heightBox * .076,
      left: widthBox * .11,
      right: widthBox * .13,
      child: Text(
        getQuestionText(),
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

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    print(_questionBank[_questionNumber].question);
    return _questionBank[_questionNumber].question;
  }

  List<String> getOptions() {
    print(_questionBank[_questionNumber].options);
    print((_questionBank[_questionNumber].incorrectAnswers));
    return _questionBank[_questionNumber].incorrectAnswers;
  }

  String getCorrectAnswer() {
    print(_questionBank[_questionNumber].correctAnswer);
    return _questionBank[_questionNumber].correctAnswer;
  }

  bool isFinished() {
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
    return _totalScore;
  }
}

class CardOptions extends StatefulWidget {
  final String title;
  final bool selected;
  final onTap;
  CardOptions({@required this.title, this.selected, this.onTap});
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
          onTap: widget.onTap,
          // onTap: () {
          //   setState(() {
          //     _selected = !_selected;
          //   });
          // },
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
