import 'package:flutter/material.dart';
import 'package:quickthink/utils/responsiveness.dart';

class CreateQuestion extends StatefulWidget {
  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController answer = TextEditingController();
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _logoText(),
                    SizedBox(height: SizeConfig().yMargin(context, 7)),
                    _prompt(),
                    _form(),
                    _saveBtn()
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _logoText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: 'Quick',
            style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig().textSize(context, 3),
                color: Colors.white)),
        TextSpan(
            text: 'Think',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig().textSize(context, 3),
              color: Color.fromRGBO(24, 197, 217, 1),
            ))
      ]),
    );
  }

  Widget _prompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Create a question',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig().textSize(context, 3.7),
          ),
        ),
      ],
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig().yMargin(context, 3.0),
          ),
          _question(),
          SizedBox(
            height: SizeConfig().yMargin(context, 4),
          ),
          _answer(),
          SizedBox(
            height: SizeConfig().yMargin(context, 4),
          ),
          _option1(),
          SizedBox(
            height: SizeConfig().yMargin(context, 4),
          ),
          _option2(),
          SizedBox(
            height: SizeConfig().yMargin(context, 4),
          ),
          _option3(),
          SizedBox(
            height: SizeConfig().yMargin(context, 4),
          ),
        ],
      ),
    );
  }

  Widget _answer() {
    return TextFormField(
      controller: answer,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig().textSize(context, 3),
          color: Colors.white),
      onChanged: (val) {},
      validator: (val) {
        if (val.length == 0) {
          return 'answer Should Not Be Empty';
        }
        if (val.length <= 2) {
          return 'should be 3 or more characters';
        }
        if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val)) {
          return "can only include _ or -";
        }
        return null;
      },
      onSaved: (val) => answer.text = val,
      decoration: InputDecoration(
        hintText: 'Enter answer',
        hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 2),
            color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
        fillColor: Color.fromRGBO(87, 78, 118, 1),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Widget _option1() {
    return TextFormField(
      controller: option1,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig().textSize(context, 3),
          color: Colors.white),
      onChanged: (val) {},
      validator: (val) {
        if (val.length == 0) {
          return 'Option Should Not Be Empty';
        }
        if (val.length <= 2) {
          return 'should be 3 or more characters';
        }
        if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val)) {
          return "can only include _ or -";
        }
        return null;
      },
      onSaved: (val) => option1.text = val,
      decoration: InputDecoration(
        hintText: 'Enter option 1',
        hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 2),
            color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
        fillColor: Color.fromRGBO(87, 78, 118, 1),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Widget _option2() {
    return TextFormField(
      controller: option2,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig().textSize(context, 3),
          color: Colors.white),
      onChanged: (val) {},
      validator: (val) {
        if (val.length == 0) {
          return 'Option Should Not Be Empty';
        }
        if (val.length <= 2) {
          return 'should be 3 or more characters';
        }
        if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val)) {
          return "can only include _ or -";
        }
        return null;
      },
      onSaved: (val) => option2.text = val,
      decoration: InputDecoration(
        hintText: 'Enter option 2',
        hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 2),
            color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
        fillColor: Color.fromRGBO(87, 78, 118, 1),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Widget _option3() {
    return TextFormField(
      controller: option3,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig().textSize(context, 3),
          color: Colors.white),
      onChanged: (val) {},
      validator: (val) {
        if (val.length == 0) {
          return 'Option Should Not Be Empty';
        }
        if (val.length <= 2) {
          return 'should be 3 or more characters';
        }
        if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val)) {
          return "can only include _ or -";
        }
        return null;
      },
      onSaved: (val) => option3.text = val,
      decoration: InputDecoration(
        hintText: 'Enter option 3',
        hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 2),
            color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
        fillColor: Color.fromRGBO(87, 78, 118, 1),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Widget _question() {
    return TextFormField(
      keyboardType: TextInputType.text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig().textSize(context, 3),
          color: Colors.white),
      onChanged: (val) {},
      controller: question,
      validator: (val) {
        if (val.length == 0) {
          return 'Question Should Not Be Empty';
        }
        if (val.length <= 2) {
          return 'should be 3 or more characters';
        }
        return null;
      },
      onSaved: (val) => question.text = val,
      decoration: InputDecoration(
        hintText: 'Enter question',
        hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 2),
            color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
        fillColor: Color.fromRGBO(87, 78, 118, 1),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Widget _saveBtn() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
      onPressed: () {
        onPressed();
      },
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color.fromRGBO(24, 197, 217, 1),
      highlightColor: Color.fromRGBO(24, 197, 217, 1),
      child: Text('Save',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.white)),
    );
  }

  void onPressed() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // print(gameCode.text + username.text);

      // _joinGame(gameCode.text, username.text);
      //    handleRegistration(nick, password);
    }
  }
}
