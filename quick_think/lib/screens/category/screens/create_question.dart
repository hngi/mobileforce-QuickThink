import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/model/question_sorting_model.dart';
import 'package:quickthink/screens/category/services/models/questions.dart';
import 'package:quickthink/screens/category/services/state/apiService.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';
import 'package:quickthink/screens/login/services/utils/validators.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'created_categories.dart';

//import 'package:quickthink/utils/quizTimer.dart';

class CreateQuestion extends StatefulHookWidget {
  static const routeName = 'create_question.dart';
  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final state = useProvider(apiState);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var heightBox = height * .618;
    var widthBox = width * .872;
    return Scaffold(
        backgroundColor: Color(0xFF1C1046),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _textTitle(height, width),
                  SizedBox(height: height * 0.02),
                  _box(height, width, heightBox, widthBox, state),
                ],
              ),
            ),
          ),
        ));
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
              child: Row(
                //overflow: Overflow.visible,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _nextButton(
                      height, width, heightBox, widthBox, apiCallService),
                ],
              ),
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
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
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
          final form = formKey.currentState;
          if (form.validate()) {
            if (correctAnswer != null) {
              form.save();
              state.createQuestion(Questions(
                  category: categoryController.text,
                  question: questionController.text,
                  answer: correctAnswer,
                  options: [
                    option1Controller.text,
                    option2Controller.text,
                    option3Controller.text,
                    option4Controller.text
                  ]));
                  categoryController.clear();
                  questionController.clear();
                  option1Controller.clear();
                  option2Controller.clear();
                  option3Controller.clear();
                  option4Controller.clear();
            } else {
              Get.snackbar('error', 'Select an answer to the question',
                  backgroundColor: Colors.red);
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
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _option1() {
    return Padding(
      padding: const EdgeInsets.only(right: 70.0),
      child: TextFormField(
        onTap: () {
          setState(() {
            correctAnswer = option1Controller.text;
            answers[0] = !answers[0];
            answers[2] = false;
            answers[1] = false;
            answers[3] = false;
          });
        },
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
          fillColor: answers[0] == false ? Colors.white : Colors.green,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC4C4C4)),
              borderRadius: BorderRadius.circular(5.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _option2() {
    return Padding(
      padding: const EdgeInsets.only(right: 70),
      child: TextFormField(
        onTap: () {
          setState(() {
            correctAnswer = option2Controller.text;
            answers[1] = !answers[1];
            answers[0] = false;
            answers[3] = false;
            answers[2] = false;
          });
        },
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
          fillColor: answers[1] == false ? Colors.white : Colors.green,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC4C4C4)),
              borderRadius: BorderRadius.circular(5.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _option3() {
    return Padding(
      padding: EdgeInsets.only(right: 70),
      child: TextFormField(
        onTap: () {
          setState(() {
            correctAnswer = option3Controller.text;
            answers[2] = !answers[2];
            answers[0] = false;
            answers[1] = false;
            answers[3] = false;
          });
        },
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
          fillColor: answers[2] == false ? Colors.white : Colors.green,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC4C4C4)),
              borderRadius: BorderRadius.circular(5.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _option4() {
    return Padding(
      padding: EdgeInsets.only(right: 70),
      child: TextFormField(
        onTap: () {
          setState(() {
            correctAnswer = option4Controller.text;
            answers[3] = !answers[3];
            answers[0] = false;
            answers[1] = false;
            answers[2] = false;
          });
        },
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
          fillColor: answers[3] == false ? Colors.white : Colors.green,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC4C4C4)),
              borderRadius: BorderRadius.circular(5.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
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
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  _textTitle(height, width) {
    return Text(
      ' Create question',
      style: GoogleFonts.poppins(
        color: Color(0xFFFFFFFF),
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
