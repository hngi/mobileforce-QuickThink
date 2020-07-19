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

  const TextFieldContainer({Key key, this.text, this.controller, this.validator, this.obscure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(10)
      ),
      // height: McGyver.rsDoubleH(context, 100),
      width: McGyver.rsDoubleW(context, 85),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          style: GoogleFonts.poppins(
            color: Colors.white
          ),
          controller: controller,
          validator: validator,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: text,
            suffixIcon: obscure ? Icon(Icons.visibility) : SizedBox(),
            labelStyle: GoogleFonts.poppins(
              fontSize: SizeConfig().textSize(context, 2.2),
              color: Colors.white,
              fontWeight: FontWeight.w500,
              
            )
          ),
        ),
      ),
    );
  }
}