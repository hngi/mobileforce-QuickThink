import 'dart:async';

import 'package:connectivity/connectivity.dart';
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
import 'package:quickthink/screens/login/widgets/button.dart';
import 'package:quickthink/screens/login/widgets/quest.dart';
import 'package:quickthink/screens/login/widgets/textfield.dart';
import 'package:quickthink/utils/responsiveness.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickthink/widgets/noInternet.dart';

//final auth = ChangeNotifierProvider((_) => LoginState());

class RegistrationScreen extends StatefulHookWidget {
  static const routeName = 'registration_screen.dart';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool obscure = true;
  final formKey = GlobalKey<FormState>();

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
            //   startTimer();
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
        Navigator.pushReplacementNamed(context, 'registration_screen.dart');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final state = useProvider(auth);

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
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: McGyver.rsDoubleW(context, 30),
                          height: McGyver.rsDoubleH(context, 20),
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/app_name_vector.png'))),
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
                        text: 'Username',
                        textInputType: TextInputType.text,
                        controller: usernameController,
                        validator: UsernameValidator.validate,
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 3)),
                      TextFieldContainer(
                        obscure: false,
                        text: 'Email',
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: EmailValidator.validate,
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 3)),
                      TextFieldContainer(
                          obscure: obscure,
                          text: 'Password',
                          textInputType: TextInputType.text,
                          controller: passwordController,
                          validator: PasswordValidator.validate,
                          suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              // splashRadius: 1,
                              icon: obscure
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              })),
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
                                        usernameController.text.trim(),
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      )
                                          .then((value) {
                                        if (value != null) {
                                          Future.delayed(Duration(seconds: 2))
                                              .then((value) =>
                                                  Get.off(LoginScreen()));
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
            ),
          );
  }
}
