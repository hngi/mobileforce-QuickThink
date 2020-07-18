import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../bottom_navigation_bar.dart';
import '../view/test.dart';
import '../../../utils/responsiveness.dart';
import '../responsiveness/res.dart';
import '../services/enum/enum.dart';
import '../services/state/state.dart';
import '../services/utils/loginUtil.dart';
import '../widgets/textfield.dart';
import '../services/utils/validators.dart';
import '../widgets/button.dart';
import '../widgets/quest.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final auth = ChangeNotifierProvider((_) => LoginState());

class LoginScreen extends StatefulHookWidget {
  static const routeName = 'login.dart';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final state = useProvider(auth);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: McGyver.rsDoubleW(context, 30),
                  height: McGyver.rsDoubleH(context, 20),
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      image: DecorationImage(
                          image: AssetImage('assets/app_name_vector.png'))),
                ),
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 2)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: McGyver.rsDoubleW(context, 9)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hey there!',
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
                    'Login to access your games',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        //fontWeight: FontWeight.w600,
                        fontSize: SizeConfig().textSize(context, 2)),
                  ),
                ),
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 5)),
              TextFieldContainer(
                text: 'Username',
                obscure: false,
                controller: usernameController,
                validator: UsernameValidator.validate,
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 3)),
              TextFieldContainer(
                text: 'Password',
                controller: passwordController,
                validator: PasswordValidator.validate,
                obscure: true,
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 5)),
              Align(
                  alignment: Alignment.center,
                  child: state.buttonState == ButtonState.Pressed
                      ? SpinKitThreeBounce(
                          color: buttonColor,
                          size: 30,
                        )
                      : LoginButton(
                          onPressed: () {
                            final form = formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              state
                                  .login(
                                usernameController.text,
                                passwordController.text,
                              )
                                  .then((value) {
                                if (value != null) {
                                  Future.delayed(Duration(seconds: 3))
                                      .then((value) => Get.to(DashboardScreen()));
                                }
                              });
                            }
                          },
                        )),
              SizedBox(height: McGyver.rsDoubleH(context, 3)),
              Quest()
            ],
          ),
        ),
      ),
    );
  }
}
