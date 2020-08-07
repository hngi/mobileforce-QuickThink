import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/screens/registration_screen.dart';

import '../../../utils/responsiveness.dart';
import '../services/utils/loginUtil.dart';

class Quest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig().textSize(context, 2)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RegistrationScreen.routeName);
          },
          child: Text(
            ' Sign Up',
            style: GoogleFonts.poppins(
                color: buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig().textSize(context, 2)),
          ),
        )
      ],
    );
  }
}

class Quest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig().textSize(context, 2)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            ' Log in',
            style: GoogleFonts.poppins(
                color: buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig().textSize(context, 2)),
          ),
        )
      ],
    );
  }
}
