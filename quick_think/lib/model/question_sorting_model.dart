import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/data/FetchedQuestions.dart';
import 'package:quickthink/model/question_ends.dart';
import 'package:quickthink/model/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuickThink extends StatefulWidget {
  final String gameCode;
  final String userName;
  final Function questionList;
  QuickThink({this.gameCode, this.userName, this.questionList});
  @override
  _QuickThinkState createState() => _QuickThinkState();
}

class _QuickThinkState extends State<QuickThink> {
  String response = "";
  int totalQuestions = 0;

  FetchedQuestions _fetchedQuestions = new FetchedQuestions();

  List<QuestionModel> fetchedQuestions;

  Future fq;

  QuestionModel questions = QuestionModel();

  
  @override
  void initState() {
  fq = _fetchedQuestions.questionUpdate(widget.gameCode, widget.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<QuestionModel>>(
        future: fq,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          print('SnapShot: ${snapshot.data}');
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<QuestionModel> questionData = snapshot.data;
            List<QuestionModel> filteredQuestions = List();

            for (QuestionModel data in questionData) {
              print('${data.incorrectAnswers.length}');
              if (data.incorrectAnswers.length >= 3) {
                filteredQuestions.add(data);
              }
            }
            return new CustomQuestionView(
                questionData: filteredQuestions, userName: widget.userName);
          }

          return new Center(
              child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ));
        });
  }
}
















class CustomQuestionView extends StatefulWidget {
  final List<QuestionModel> questionData;
  final String userName;
  final String gameCode;

  CustomQuestionView({this.questionData, this.userName,this.gameCode});

  @override
  _CustomQuestionViewState createState() => _CustomQuestionViewState();
}

class _CustomQuestionViewState extends State<CustomQuestionView> {
  QuickThink quickThink;

  String userAnswer;

  int _correctResponse = 0;
  int _wrongResponse = 0;
  int _questionNumber = 0;
  String response = "";
  int totalQuestions = 0;
  int _totalScore = 0;
  List<QuestionModel> _questionBank;
  String userResponse;
  String userPickedAnswer;

  String _userName;

  List<bool> isPicked = [false, false, false, false];

  var style = GoogleFonts.poppins(
    color: Color(0xFF1C1046),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

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
    print('_questionBank: $_questionBank');
    this.getUserName();

    //quickThink = QuickThink(difficultyLevel: widget.difficultyLevel);
    super.initState();
  }

 Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return Container(
      child: Stack(
        children: <Widget>[
          _progress(height, width),
          _box(height,width,heightBox,widthBox),
        ],
      ),
    );
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
              _progress(height, width),
              //_nextButton(height, width, heightBox, widthBox),
              _question(heightBox, widthBox),
              

              Positioned(
                  top: heightBox * .26,
                  left: widthBox * .055,
                  right: widthBox * .055,
                  child: Column(
                    children: _options(),
                  )),
              // _optionOne(heightBox, widthBox),
              // _optionTwo(heightBox, widthBox),
              // _optionThree(heightBox, widthBox),
              // _optionFour(heightBox, widthBox)
            ],
          ),
        ));
  }

  _options() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    List<Widget> option = List();
    bool _isSelected = false;

    for (var i = 0; i < getOptions().length; i++) {
      //isPicked.add(false);
      option.add(
        InkWell(
          onTap: () {
            //isPicked = [false, false, false, false];
            setState(() {
              _isSelected = !_isSelected;
              isPicked[i] = _isSelected;
              userAnswer = getOptions()[i];
              print(isPicked);
            });
             print('getUserPickedAnswer:$userAnswer');

            if (userAnswer.isNotEmpty && userAnswer != null) {
              checkAnswer(userAnswer);
              //isPicked = [false, false, false, false];
            }
          },
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isPicked[i] ? Colors.green : Colors.white,
                    border: Border.all(color: Colors.black26)),
                height: heightBox * .128,
                width: widthBox * .77,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      getOptions()[i],
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

  // Widget _optionOne(heightBox, widthBox) {
  //   return Positioned(
  //     top: heightBox * .26,
  //     left: widthBox * .055,
  //     right: widthBox * .055,
  //     child: CardOptions(
  //       title: getOptions()[0],
  //       onTap: () {
  //         setState(() {
  //           userAnswer = getOptions()[0];
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _optionTwo(heightBox, widthBox) {
  //   return Positioned(
  //     top: heightBox * .408,
  //     left: widthBox * .055,
  //     right: widthBox * .055,
  //     child: CardOptions(
  //       title: getOptions()[1],
  //       onTap: () {
  //         setState(() {
  //           userAnswer = getOptions()[1];
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _optionThree(heightBox, widthBox) {
  //   return Positioned(
  //     top: heightBox * .55,
  //     left: widthBox * .055,
  //     right: widthBox * .055,
  //     child: CardOptions(
  //       title: getOptions()[2],
  //       onTap: () {
  //         setState(() {
  //           userAnswer = getOptions()[2];
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _optionFour(heightBox, widthBox) {
  //   return Positioned(
  //     top: heightBox * .70,
  //     left: widthBox * .055,
  //     right: widthBox * .055,
  //     child: CardOptions(
  //       title: getOptions()[3],
  //       onTap: () {
  //         setState(() {
  //           userAnswer = getOptions()[3];
  //         });
  //       },
  //       selected: true,
  //     ),
  //   );
  // }

  Widget _progress(height, width) {
    return Positioned(
        top: height * .17,
        left: width * .064,
        child: Text(
          'Question ' +
              currentQuestion().toString() +
              ' of ' +
              numberOfQuestions().toString(),
          style: GoogleFonts.poppins(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  // Widget _nextButton(height, width, heightBox, widthBox) {
  //   return Positioned(
  //     top: heightBox * .89,
  //     left: widthBox * .58,
  //     right: widthBox * .0,
  //     bottom: heightBox * .0,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5.0),
  //         color: Color(0xFF18C5D9),
  //       ),
  //       height: height * .069,
  //       width: width * .368,
  //       child: FlatButton(
  //         child: Text(
  //           'Next',
  //           style: style.copyWith(
  //             fontWeight: FontWeight.bold,
  //             color: Color(0xFFFFFFFF),
  //             fontSize: 16,
  //             letterSpacing: 0.5,
  //           ),
  //         ),
  //         onPressed: () {
  //           print('getUserPickedAnswer:$userAnswer');

  //           if (userAnswer.isNotEmpty && userAnswer != null) {
  //             checkAnswer(userAnswer);
  //             isPicked = [false, false, false, false];
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  bool isCorrect(String userResponse){
    bool correct = true;
    String correctAnswer = getCorrectAnswer();
    if(userResponse == correctAnswer){
      return correct;
    }else{
      return correct = false;
    }
  }

  void checkAnswer(String option) {
    String correctAnswer = getCorrectAnswer();

    setState(() {
      userResponse = option;

      if (userResponse == correctAnswer) {
        incrementScore();
        isPicked = [false, false, false, false];
        if (isFinished() == true) {
//        Navigator.sth to the results page
//      Throw an alert to the user that evaluation has finished
          IQEnds(
            totalScore: totalScore,
            username: _userName,
              gameCode: widget.gameCode
          ).showEndMsg(context);

          reset();
        }
        nextQuestion();
      } else {
        decrementScore();
isPicked = [false, false, false, false];
        if (isFinished() == true) {
//        Navigator.sth to the results page
//      Throw an alert to the user that evaluation has finished
          IQEnds(
            totalScore: totalScore,
            username: _userName,
            gameCode: widget.gameCode
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
}

class CardOptions extends StatefulWidget {
  final String title;
  final bool selected;
  final onTap;

  final Color color;
  CardOptions({@required this.title, this.selected, this.color, this.onTap});

  @override
  _CardOptionsState createState() => _CardOptionsState();
}

class _CardOptionsState extends State<CardOptions> {
  bool _selected = false;

  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  _CustomQuestionViewState view = _CustomQuestionViewState();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return Column(
      children: <Widget>[
        SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.color, //_selected ? Colors.green : Colors.white,

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

        //),
      ],
    );
  }
}
