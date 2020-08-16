import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/forgot_password/views/successReset.dart';
import 'package:quickthink/screens/login/responsiveness/res.dart';
import 'package:quickthink/screens/login/services/enum/enum.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/screens/login/services/utils/snackbar.dart';
import 'package:quickthink/screens/login/services/utils/validators.dart';
import 'package:quickthink/screens/login/widgets/button.dart';
import 'package:quickthink/screens/login/widgets/textfield.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:quickthink/widgets/noInternet.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../forgot_password_view_model.dart';

final forgot = ChangeNotifierProvider((_) => ForgotPasswordState());

class ForgotPassword extends StatefulHookWidget {
  static const routeName = 'login.dart';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool obscure = true;
  bool obscure2 = true;
  final formKey = GlobalKey<FormState>();

  String text = 'New Password';
  String text2 = 'Confirm New Password';

  //Check Internet Connectivity
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool _connection = false;

  @override
  void initState() {
//Check Internet Connectivity
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult connectivityResult) {
        _connectionStatus = connectivityResult.toString();
        print(_connectionStatus);
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          if (!mounted) return;
          setState(() {
            //    startTimer();
            _connection = false;
          });
        } else {
          if (!mounted) return;
          setState(() {
            _connection = true;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

//Navigate to Page When Connectivity is back
  startTimer() async {
    return new Timer(
      Duration(milliseconds: 500),
      () {
        Navigator.pushReplacementNamed(context, 'login.dart');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordControllerAgain = useTextEditingController();
    final state = useProvider(forgot);

    return _connection
        ? NoInternet()
        : Scaffold(
            backgroundColor: backgroundColor,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: McGyver.rsDoubleH(context, 7)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Text(
                              'Back',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig().textSize(context, 3)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 4)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: McGyver.rsDoubleW(context, 9)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Reset your password',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig().textSize(context, 3)),
                          ),
                        ),
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 2)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: McGyver.rsDoubleW(context, 9)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please enter the details to reset your password',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                //fontWeight: FontWeight.w600,
                                fontSize: SizeConfig().textSize(context, 2)),
                          ),
                        ),
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 5)),
                      TextFieldContainer(
                        text: 'Email',
                        obscure: false,
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: EmailValidator.validate,
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 3)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig().xMargin(context, 7.0)),
                        child: TextFormField(
                          style: GoogleFonts.poppins(color: Colors.white),
                          controller: passwordController,
                          validator: PasswordValidator.validate,
                          obscureText: obscure,
                          decoration: InputDecoration(
                              fillColor: textFieldColor,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 197, 217, 1),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(9)),
                              labelText: text,
                              suffixIcon: text == 'New Password'
                                  ? IconButton(
                                      icon: obscure
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          obscure = !obscure;
                                        });
                                      },
                                    )
                                  : SizedBox(),
                              labelStyle: GoogleFonts.poppins(
                                fontSize: SizeConfig().textSize(context, 2.2),
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 3)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig().xMargin(context, 7.0)),
                        child: TextFormField(
                          style: GoogleFonts.poppins(color: Colors.white),
                          controller: passwordControllerAgain,
                          validator: PasswordValidator.validate,
                          obscureText: obscure2,
                          decoration: InputDecoration(
                              fillColor: textFieldColor,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 197, 217, 1),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(9)),
                              labelText: text2,
                              suffixIcon: text2 == 'Confirm New Password'
                                  ? IconButton(
                                      icon: obscure2
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          obscure2 = !obscure2;
                                        });
                                      },
                                    )
                                  : SizedBox(),
                              labelStyle: GoogleFonts.poppins(
                                fontSize: SizeConfig().textSize(context, 2.2),
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 5)),
                      Align(
                          alignment: Alignment.center,
                          child: state.buttonState == ButtonState.Pressed
                              ? SpinKitThreeBounce(
                                  color: buttonColor,
                                  size: 30,
                                )
                              : ForgotPasswordButton(
                                  onPressed: () {
                                    final form = formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      if (!(passwordController.text.trim() ==
                                          passwordControllerAgain.text
                                              .trim())) {
                                        SnackBarService.instance
                                            .showSnackBarError(
                                                'Passwords do not match!');
                                      } else {
                                        print(emailController.text);
                                        print(passwordController.text);
                                        state
                                            .forgotPassword(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                        )
                                            .then((value) {
                                          if (value != null) {
                                            Future.delayed(Duration(seconds: 3))
                                                .then((value) =>
                                                    Get.offAll(ResetSuccess()));
                                          }
                                        });
                                      }
                                    }
                                  },
                                )),
                      SizedBox(height: McGyver.rsDoubleH(context, 3)),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
