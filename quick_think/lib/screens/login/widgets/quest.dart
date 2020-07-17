import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/responsiveness.dart';
import '../services/utils/loginUtil.dart';

class Quest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account? ',
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig().textSize(context, 2)),),
        Text(
          ' Sign Up',
          style: GoogleFonts.poppins(
              color: buttonColor,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig().textSize(context, 2)),
        )
      ],
    );
  }
}
