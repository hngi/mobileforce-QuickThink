import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/bottom_navigation_bar.dart';
import 'package:quickthink/screens/login/responsiveness/res.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/screens/login/view/login.dart';
import 'package:quickthink/screens/login/widgets/button.dart';
import 'package:quickthink/screens/new_dashboard.dart';
import 'package:quickthink/utils/responsiveness.dart';

class ResetSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: McGyver.rsDoubleW(context, 5)),
        child: Column(
          children: [
            SizedBox(height: McGyver.rsDoubleH(context, 25)),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Password reset success',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig().textSize(context, 3)),
              ),
            ),
            SizedBox(height: McGyver.rsDoubleH(context, 2)),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your Password has been reset successfully!',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    //fontWeight: FontWeight.w600,
                    fontSize: SizeConfig().textSize(context, 2)),
              ),
            ),
            SizedBox(height: McGyver.rsDoubleH(context, 15)),
            Align(
              alignment: Alignment.center,
              child: ResetSuccessButton(
                onPressed: () {
                  Get.offAll(LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
