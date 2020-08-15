import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/bottom_navigation_bar.dart';
import 'package:quickthink/model/question_sorting_model.dart';
import 'package:quickthink/screens/category/screens/viewQuestions.dart';
import 'package:quickthink/screens/category/services/models/questions.dart';
import 'package:quickthink/screens/category/services/state/apiService.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';
import 'package:quickthink/screens/login/services/enum/enum.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/screens/login/services/utils/validators.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quickthink/widgets/noInternet.dart';
import 'created_categories.dart';

//import 'package:quickthink/utils/quizTimer.dart';
enum QuestionState { Editing, Adding }

class CreateQuestion extends StatefulHookWidget {
  final QuestionState questionState;
  static const routeName = 'create_question.dart';
  final Map<String, dynamic> question;
  String categoryName;
  CreateQuestion({
    @required this.questionState,
    this.question,
    @required this.categoryName,
  });
  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
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
    if (widget.questionState == QuestionState.Editing) {
      categoryController.text = widget.question['category'];
      questionController.text = widget.question['question'];
      option1Controller.text = widget.question['options'][0];
      option2Controller.text = widget.question['options'][1];
      option3Controller.text = widget.question['options'][2];
      option4Controller.text = widget.question['options'][3];
      for (var i = 0; i < widget.question['options'].length; i++) {
        if (widget.question['options'][i] == widget.question['answer']) {
          answers[i] = true;
          correctAnswer = widget.question['options'][i];
        }
      }
    } else {
      categoryController.text = widget.categoryName;
    }

    super.initState();
  }

  //Navigate to Page When Connectivity is back
  startTimer() async {
    return new Timer(
      Duration(milliseconds: 500),
      () {
        Navigator.pushReplacementNamed(context, 'created_categories');
      },
    );
  }

  var style = GoogleFonts.poppins(
    color: Color(0xFF1C1046),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  TextEditingController categoryController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  List<bool> answers = [false, false, false, false];
  String correctAnswer;
  final formKey = GlobalKey<FormState>();
  bool changed = false;

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = useProvider(apiState);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;

    return Scaffold(
        backgroundColor: Color(0xFF1C1046),
        body: !_connection
            ? changed
                ? GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig().xMargin(context, 10)),
                      child: Card(
                          color: Color(0xFF1C1046),
                          child: Container(
                            height: SizeConfig().yMargin(context, 20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: 10,
                                  spacing: 10,
                                  children: [
                                    RaisedButton(
                                      color: buttonColor,
                                      onPressed: () {
                                        Get.off(ViewQuestions());
                                      },
                                      child: Text('View All Questions'),
                                    ),
                                    // Spacer(),
                                    RaisedButton(
                                      color: buttonColor,
                                      onPressed: () {
                                        setState(() {
                                          changed = false;
                                        });
                                      },
                                      child: Text('New Question'),
                                    ),
                                    RaisedButton(
                                      color: buttonColor,
                                      onPressed: () {
                                        Get.off(DashboardScreen());
                                      },
                                      child: Text('DashBoard'),
                                    ),
                                  ]),
                            ),
                          )),
                    )),
                  )
                : SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                color: buttonColor,
                                icon: Icon(Icons.arrow_back),
                                onPressed: () => Get.back(),
                              ),
                            ),
                            _textTitle(height, width),
                            SizedBox(height: height * 0.02),
                            _box(height, width, heightBox, widthBox, state),
                          ],
                        ),
                      ),
                    ),
                  )
            : NoInternet());
  }

  Widget _box(
      height, width, heightBox, widthBox, ApiCallService apiCallService) {
    return Container(
      width: width,
      height: heightBox * 1.3,
      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height * 0.015,
            ),
            _category(),
            SizedBox(
              height: height * 0.015,
            ),
            Flexible(flex: 1, child: _questionTextBox()),
            SizedBox(
              height: height * 0.04,
            ),
            Flexible(flex: 1, child: _question1()),
            SizedBox(
              height: height * 0.015,
            ),
            Flexible(flex: 1, child: _questionsTextBox()),
            SizedBox(
              height: height * 0.015,
            ),
            Flexible(flex: 1, child: _option1()),
            SizedBox(
              height: height * 0.015,
            ),
            Flexible(flex: 1, child: _option2()),
            SizedBox(
              height: height * 0.015,
            ),
            Flexible(flex: 1, child: _option3()),
            SizedBox(
              height: height * 0.03,
            ),
            Flexible(flex: 1, child: _option4()),
            SizedBox(
              height: height * 0.03,
            ),
            // Card(
            //     elevation: 1,
            //     color: Color(0xffDEDEE0),
            //     child: Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Container(
            //         width: width * 0.3,
            //         height: height * 0.03,
            //         child: Row(
            //           children: <Widget>[
            //             Icon(Icons.add, size: 20),
            //             Text('New question'),
            //           ],
            //         ),
            //       ),
            //     )),
            Align(
              alignment: Alignment.bottomRight,
              child: apiCallService.buttonState == ButtonState.Pressed
                  ? SpinKitThreeBounce(
                      size: 30,
                      color: buttonColor,
                    )
                  : _nextButton(
                      height, width, heightBox, widthBox, apiCallService),
            )
          ],
        ),
      ),
    );
  }

  Widget _nextButton(height, width, heightBox, widthBox, ApiCallService state) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)),
        color: Color(0xFF18C5D9),
      ),
      height: height * .079,
      width: width * .468,
      child: FlatButton(
        child: Text(
          'Save and View',
          style: style.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
        onPressed: () {
          if (widget.questionState == QuestionState.Adding) {
            final form = formKey.currentState;

            if (form.validate()) {
              if (correctAnswer != null) {
                form.save();
                // print(option1Controller.text);
                // print(option2Controller.text);
                // print(option3Controller.text);
                // print(option4Controller.text);
                state
                    .createQuestion(Questions(
                        category: categoryController.text.trim(),
                        question: questionController.text.trim(),
                        answer: correctAnswer.trim(),
                        options: [
                      option1Controller.text.trim(),
                      option2Controller.text.trim(),
                      option3Controller.text.trim(),
                      option4Controller.text.trim(),
                    ]))
                    .then((value) {
                  if (value != null) {
                    categoryController.clear();
                    questionController.clear();
                    option1Controller.clear();
                    option2Controller.clear();
                    option3Controller.clear();
                    option4Controller.clear();
                    setState(() {
                      answers[0] = false;
                      answers[1] = false;
                      answers[2] = false;
                      answers[3] = false;
                      changed = true;
                    });
                  }
                });
              } else {
                Get.snackbar('error', 'Select an answer to the question',
                    backgroundColor: Colors.red);
              }
            }
          } else {
            final form = formKey.currentState;
            if (form.validate()) {
              if (correctAnswer != null) {
                form.save();
                state
                    .editQuestion(Questions(
                        id: widget.question['id'],
                        category: categoryController.text,
                        question: questionController.text,
                        answer: correctAnswer,
                        options: [
                      option1Controller.text,
                      option2Controller.text,
                      option3Controller.text,
                      option4Controller.text
                    ]))
                    .then((value) {
                  if (value != null) {
                    categoryController.clear();
                    questionController.clear();
                    option1Controller.clear();
                    option2Controller.clear();
                    option3Controller.clear();
                    option4Controller.clear();
                    setState(() {
                      answers[0] = false;
                      answers[1] = false;
                      answers[2] = false;
                      answers[3] = false;
                      changed = true;
                    });
                  }
                });
              } else {
                Get.snackbar('error', 'Select an answer to the question',
                    backgroundColor: Colors.red);
              }
            }
          }
          // Navigator.pushNamed(context, CreatedCategories.routeName);
        },
      ),
    );
  }

  Widget _category() {
    return Text(
      'Category',
      style: GoogleFonts.poppins(
        color: Color(0xFF38208C),
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        // fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _question1() {
    return Text(
      'Question 1 (tick correct answer)',
      style: GoogleFonts.poppins(
        color: Color(0xFF38208C),
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        // fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _questionTextBox() {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: TextFormField(
        controller: categoryController,
        keyboardType: TextInputType.text,
        validator: PasswordValidator.validate,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            //  fontSize: SizeConfig().textSize(context, 3),
            color: Color(0xff38208C)),
        onChanged: (val) {},
        decoration: InputDecoration(
          hintText: 'Type category here',
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              //  fontSize: SizeConfig().textSize(context, 2),
              color: Color(0xff38208C)),
          contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC4C4C4)),
              borderRadius: BorderRadius.circular(5.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(24, 197, 217, 1)),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _option1() {
    return Padding(
        padding: const EdgeInsets.only(right: 70.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: SizeConfig().xMargin(context, 70),
                child: TextFormField(
                  controller: option1Controller,
                  keyboardType: TextInputType.text,
                  validator: PasswordValidator.validate,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      //  fontSize: SizeConfig().textSize(context, 3),
                      color: Color(0xff38208C)),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    hintText: 'Options 1',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        //  fontSize: SizeConfig().textSize(context, 2),
                        color: Color(0xff38208C)),
                    contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC4C4C4)),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(24, 197, 217, 1)),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  correctAnswer = option1Controller.text;
                  answers[0] = !answers[0];
                  if (!answers[0]) {
                    correctAnswer = null;
                  }
                  answers[2] = false;
                  answers[1] = false;
                  answers[3] = false;
                });
              },
              child: CircleAvatar(
                backgroundColor:
                    answers[0] == false ? Colors.white : Colors.green,
                child: answers[0] == false
                    ? Icon(Icons.cancel)
                    : Icon(Icons.check),
              ),
            )
          ],
        ));
  }

  Widget _option2() {
    return Padding(
        padding: const EdgeInsets.only(right: 70),
        child: Row(children: [
          Expanded(
            child: Container(
              width: SizeConfig().xMargin(context, 50),
              child: TextFormField(
                controller: option2Controller,
                keyboardType: TextInputType.text,
                validator: PasswordValidator.validate,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    //  fontSize: SizeConfig().textSize(context, 3),
                    color: Color(0xff38208C)),
                onChanged: (val) {},
                decoration: InputDecoration(
                  hintText: 'Options 2',
                  hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      //  fontSize: SizeConfig().textSize(context, 2),
                      color: Color(0xff38208C)),
                  contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4C4C4)),
                      borderRadius: BorderRadius.circular(5.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(24, 197, 217, 1)),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                correctAnswer = option2Controller.text;
                answers[1] = !answers[1];
                if (!answers[1]) {
                  correctAnswer = null;
                }
                answers[0] = false;
                answers[3] = false;
                answers[2] = false;
              });
            },
            child: CircleAvatar(
              backgroundColor:
                  answers[1] == false ? Colors.white : Colors.green,
              child:
                  answers[1] == false ? Icon(Icons.cancel) : Icon(Icons.check),
            ),
          )
        ]));
  }

  Widget _option3() {
    return Padding(
        padding: EdgeInsets.only(right: 70),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: SizeConfig().xMargin(context, 50),
                child: TextFormField(
                  controller: option3Controller,
                  keyboardType: TextInputType.text,
                  validator: PasswordValidator.validate,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      //  fontSize: SizeConfig().textSize(context, 3),
                      color: Color(0xff38208C)),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    hintText: 'Options 3',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        //  fontSize: SizeConfig().textSize(context, 2),
                        color: Color(0xff38208C)),
                    contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC4C4C4)),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(24, 197, 217, 1)),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  correctAnswer = option3Controller.text;
                  answers[2] = !answers[2];
                  if (!answers[2]) {
                    correctAnswer = null;
                  }
                  answers[0] = false;
                  answers[1] = false;
                  answers[3] = false;
                });
              },
              child: CircleAvatar(
                backgroundColor:
                    answers[2] == false ? Colors.white : Colors.green,
                child: answers[2] == false
                    ? Icon(Icons.cancel)
                    : Icon(Icons.check),
              ),
            )
          ],
        ));
  }

  Widget _option4() {
    return Padding(
        padding: EdgeInsets.only(right: 70),
        child: Row(children: [
          Expanded(
            child: Container(
              width: SizeConfig().xMargin(context, 50),
              child: TextFormField(
                controller: option4Controller,
                keyboardType: TextInputType.text,
                validator: PasswordValidator.validate,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    //  fontSize: SizeConfig().textSize(context, 3),
                    color: Color(0xff38208C)),
                onChanged: (val) {},
                decoration: InputDecoration(
                  hintText: 'Options 4',
                  hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      //  fontSize: SizeConfig().textSize(context, 2),
                      color: Color(0xff38208C)),
                  contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4C4C4)),
                      borderRadius: BorderRadius.circular(5.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(24, 197, 217, 1)),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                correctAnswer = option4Controller.text;
                answers[3] = !answers[3];
                if (!answers[3]) {
                  correctAnswer = null;
                }
                answers[0] = false;
                answers[1] = false;
                answers[2] = false;
              });
            },
            child: CircleAvatar(
              backgroundColor:
                  answers[3] == false ? Colors.white : Colors.green,
              child:
                  answers[3] == false ? Icon(Icons.cancel) : Icon(Icons.check),
            ),
          )
        ]));
  }

  Widget _questionsTextBox() {
    return Padding(
      padding: EdgeInsets.only(
        right: 20,
      ),
      child: TextFormField(
        controller: questionController,
        keyboardType: TextInputType.text,
        validator: PasswordValidator.validate,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            //  fontSize: SizeConfig().textSize(context, 3),
            color: Color(0xff38208C)),
        onChanged: (val) {},
        decoration: InputDecoration(
          hintText: 'Type question here',
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              //  fontSize: SizeConfig().textSize(context, 2),
              color: Color(0xff38208C)),
          contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC4C4C4)),
              borderRadius: BorderRadius.circular(5.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(24, 197, 217, 1)),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  _textTitle(height, width) {
    return Text(
      '${widget.categoryName} category',
      style: GoogleFonts.poppins(
        color: Color(0xFFFFFFFF),
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
