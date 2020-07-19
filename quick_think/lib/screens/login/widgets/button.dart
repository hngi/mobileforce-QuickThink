import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/responsiveness.dart';
import '../responsiveness/res.dart';
import '../services/utils/loginUtil.dart';

class LoginButton extends StatelessWidget {
  final Function onPressed;

  const LoginButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: McGyver.rsDoubleW(context, 85),
      child: MaterialButton(
          child: Text(
            'Login',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: SizeConfig().textSize(context, 2.4)),
          ),
          height: McGyver.rsDoubleH(context, 9.7),
          color: buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: onPressed),
    );
  }
}

class SignUpButton extends StatelessWidget {
  final Function onPressed;

  const SignUpButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: McGyver.rsDoubleW(context, 85),
      child: MaterialButton(
          child: Text(
            'Create Account',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: SizeConfig().textSize(context, 2.4)),
          ),
          height: McGyver.rsDoubleH(context, 9.7),
          color: buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: onPressed),
    );
  }
}
