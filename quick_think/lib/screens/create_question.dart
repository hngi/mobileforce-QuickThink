import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/model/question_sorting_model.dart';
import 'package:quickthink/screens/created_categories.dart';
//import 'package:quickthink/utils/quizTimer.dart';

class CreateQuestion extends StatefulWidget {
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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _textTitle(height, width),
                  SizedBox(height: height * 0.02),
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
      height: heightBox * 1.3,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(5.0),
        color: Color(0xFFFFFFFF),
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
            Card(
                elevation: 1,
                color: Color(0xffDEDEE0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.03,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.add, size: 20),
                        Text('New question'),
                      ],
                    ),
                  ),
                )),
            Row(
              //overflow: Overflow.visible,
              children: <Widget>[
                Spacer(),
                _nextButton(height, width, heightBox, widthBox),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _nextButton(height, width, heightBox, widthBox) {
    return Positioned(
      // top: heightBox * .89,
      // left: widthBox * .58,
      // right: widthBox * .0,
      // bottom: heightBox,
      width: 70,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          color: Color(0xFF18C5D9),
        ),
        height: height * .069,
        width: width * .368,
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
            Navigator.pushNamed(context, CreatedCategories.routeName);
          },
        ),
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
      'Question 1',
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
        keyboardType: TextInputType.text,
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
        keyboardType: TextInputType.text,
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
        keyboardType: TextInputType.text,
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
        keyboardType: TextInputType.text,
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
        keyboardType: TextInputType.text,
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
