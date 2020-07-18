import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/category/screens/created_categories.dart';
import 'package:quickthink/screens/category/services/state/apiService.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';
import 'package:quickthink/screens/login/services/enum/enum.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';

import 'package:quickthink/utils/responsiveness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'create_question.dart';

class CreateCategory extends StatefulHookWidget {
  static const routeName = 'create_category';
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final state = useProvider(apiState);
    final controller = useTextEditingController();
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
                  height: SizeConfig().yMargin(context, 2),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    color: buttonColor,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig().yMargin(context, 4),
                ),
                _prompt(),
                _form(controller),
                state.buttonState == ButtonState.Idle
                    ? _loginBtn(state, controller)
                    : SpinKitThreeBounce(
                        color: buttonColor,
                        size: 30,
                      ),
                SizedBox(height: SizeConfig().yMargin(context, 3)),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(CreatedCategories());
                    },
                    child: Text(
                      'View Categories',
                      style: GoogleFonts.poppins(
                          color: buttonColor,
                          fontSize: SizeConfig().textSize(context, 2.6)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _prompt() {
    return Text(
      'Create category',
      style: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig().textSize(context, 3.7),
      ),
    );
  }

  Widget _form(TextEditingController controller) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig().yMargin(context, 3.0),
          ),
          _promptCategory(),
          SizedBox(
            height: SizeConfig().yMargin(context, 1),
          ),
          _category(controller),
          SizedBox(
            height: SizeConfig().yMargin(context, 7),
          ),
        ],
      ),
    );
  }

  Widget _category(TextEditingController controller) {
    return TextFormField(
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig().textSize(context, 3),
          color: Colors.white),
      controller: controller,
      validator: (val) {
        if (val.length == 0) {
          return 'Field Should Not Be Empty';
        }
        if (val.length <= 2) {
          return 'should be 3 or more characters';
        }
        if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val)) {
          return "can only include _ or -";
        }
        return null;
      },
      // onSaved: (val) => username.text = val,
      decoration: InputDecoration(
        hintText: 'Type category here',
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

  Widget _loginBtn(
      ApiCallService apiCallService, TextEditingController controller) {
    return Builder(
      builder: (BuildContext context) {
        return RaisedButton(
          padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
          onPressed: () async {
            final form = formKey.currentState;
            if (form.validate()) {
              form.save();
              print(controller.text);
              apiCallService.createCategory(controller.text);
              controller.clear();
            }
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
      },
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
