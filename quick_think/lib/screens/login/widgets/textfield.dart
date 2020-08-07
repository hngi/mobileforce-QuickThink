import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/responsiveness.dart';
import '../responsiveness/res.dart';
import '../services/utils/loginUtil.dart';

class TextFieldContainer extends StatelessWidget {
  final bool obscure;
  final String text;
  final TextEditingController controller;
  final String Function(String) validator;
  final Widget suffixIcon;
  final TextInputType textInputType;
  const TextFieldContainer({
    Key key,
    this.text,
    this.controller,
    this.validator,
    this.obscure,
    this.suffixIcon,
    this.textInputType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig().xMargin(context, 7.0)),
      child: TextFormField(
        style: GoogleFonts.poppins(color: Colors.white),
        controller: controller,
        validator: validator,
        obscureText: obscure,
        keyboardType: textInputType,
        decoration: InputDecoration(

            // contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
            fillColor: textFieldColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
                borderRadius: BorderRadius.circular(9)),
            labelText: text,
            suffixIcon: text == 'Password' ? suffixIcon : SizedBox(),
            labelStyle: GoogleFonts.poppins(
              fontSize: SizeConfig().textSize(context, 2.2),
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}

class TextFieldReset extends StatelessWidget {
  final bool obscure;
  final String text;
  final TextEditingController controller;
  final String Function(String) validator;
  final Widget suffixIcon;

  const TextFieldReset(
      {Key key,
      this.text,
      this.controller,
      this.validator,
      this.obscure,
      this.suffixIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig().xMargin(context, 7.0)),
      child: TextFormField(
        style: GoogleFonts.poppins(color: Colors.white),
        controller: controller,
        validator: validator,
        obscureText: obscure,
        decoration: InputDecoration(

            // contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
            fillColor: textFieldColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
                borderRadius: BorderRadius.circular(9)),
            labelText: text,
            suffixIcon: text == 'Password' ? suffixIcon : SizedBox(),
            labelStyle: GoogleFonts.poppins(
              fontSize: SizeConfig().textSize(context, 2.2),
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}
