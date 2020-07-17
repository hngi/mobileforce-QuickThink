import 'package:flutter/material.dart';
import 'package:quickthink/screens/create_question.dart';
import 'package:quickthink/utils/responsiveness.dart';

class CreatedCategories extends StatefulWidget {
  static const routeName = 'created_categories';
  @override
  _CreatedCategoriesState createState() => _CreatedCategoriesState();
}

class _CreatedCategoriesState extends State<CreatedCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: SizeConfig().xMargin(context, 5.0),
            right: SizeConfig().xMargin(context, 5.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig().yMargin(context, 10),
                ),
                _prompt(),
                SizedBox(
                  height: SizeConfig().yMargin(context, 5),
                ),
                _cards(),
                SizedBox(
                  height: SizeConfig().yMargin(context, 3),
                ),
                _cards1()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _prompt() {
    return Text(
      'Created categories',
      style: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig().textSize(context, 3.7),
      ),
    );
  }

  Widget _cards() {
    return Card(
        color: Color(0xff38208C),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: <Widget>[
              Text(
                'math category',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig().textSize(context, 2),
                ),
              ),
              Spacer(),
              Text(
                '1h ago',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  //fontWeight: FontWeight.w600,
                  fontSize: SizeConfig().textSize(context, 2),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _cards1() {
    return Card(
        color: Color(0xff38208C),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: <Widget>[
              Text(
                'French category',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig().textSize(context, 2),
                ),
              ),
              Spacer(),
              Text(
                '1 day ago',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  //fontWeight: FontWeight.w600,
                  fontSize: SizeConfig().textSize(context, 2),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _loginBtn() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
      onPressed: () {
        //onPressed();
        Navigator.pushNamed(context, CreateQuestion.routeName);
      },
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
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

  Widget _promptCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Category',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig().textSize(context, 2.2),
          ),
        ),
      ],
    );
  }
}
