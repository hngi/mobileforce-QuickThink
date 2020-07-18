import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/login/responsiveness/res.dart';
import 'package:quickthink/screens/login/services/enum/enum.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/screens/login/services/utils/validators.dart';
import 'package:quickthink/screens/login/view/login.dart';
import 'package:quickthink/screens/login/view/test.dart';
import 'package:quickthink/screens/login/widgets/button.dart';
import 'package:quickthink/screens/login/widgets/quest.dart';
import 'package:quickthink/screens/login/widgets/textfield.dart';
import 'package:quickthink/utils/responsiveness.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

//final auth = ChangeNotifierProvider((_) => LoginState());

class RegistrationScreen extends StatefulHookWidget {
  static const routeName = 'registration_screen.dart';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
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
                    'Sign up to play cool games',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        //fontWeight: FontWeight.w600,
                        fontSize: SizeConfig().textSize(context, 2)),
                  ),
                ),
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 5)),
              TextFieldContainer(
                obscure: false,
                text: 'Name',
                controller: usernameController,
                validator: UsernameValidator.validate,
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 3)),
              TextFieldContainer(
                obscure: false,
                text: 'Email',
                controller: emailController,
                validator: EmailValidator.validate,
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 3)),
              TextFieldContainer(
                obscure: true,
                text: 'Password',
                controller: passwordController,
                validator: PasswordValidator.validate,
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 5)),
              Align(
                  alignment: Alignment.center,
                  child: state.buttonState == ButtonState.Pressed
                      ? SpinKitThreeBounce(
                          color: buttonColor,
                          size: 30,
                        )
                      : SignUpButton(
                          onPressed: () {
                            final form = formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              state
                                  .signup(
                                usernameController.text,
                                emailController.text,
                                passwordController.text,
                              )
                                  .then((value) {
                                if (value != null) {
                                  Future.delayed(Duration(seconds: 2))
                                      .then((value) => Get.to(LoginScreen()));
                                }
                              });
                            }
                          },
                        )),
              SizedBox(height: McGyver.rsDoubleH(context, 3)),
              Quest2()
            ],
          ),
        ),
      ),
    );
  }
}
