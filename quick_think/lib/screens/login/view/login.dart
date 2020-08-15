import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/forgot_password/views/forgot_password.dart';
import 'package:quickthink/widgets/noInternet.dart';
import '../../../bottom_navigation_bar.dart';
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
    final usernameController = useTextEditingController();
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
                        textInputType: TextInputType.text,
                        obscure: false,
                        controller: usernameController,
                        validator: UsernameValidator.validate,
                      ),
                      SizedBox(height: McGyver.rsDoubleH(context, 3)),
                      TextFieldContainer(
                          text: 'Password',
                          controller: passwordController,
                          textInputType: TextInputType.text,
                          validator: PasswordValidator.validate,
                          obscure: obscure,
                          suffixIcon: IconButton(
                              icon: obscure
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              })),
                      SizedBox(height: McGyver.rsDoubleH(context, 1)),
                      GestureDetector(
                        onTap: () {
                          Get.to(ForgotPassword());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: McGyver.rsDoubleW(context, 9)),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              ' Forgot Password?',
                              style: GoogleFonts.poppins(
                                  color: buttonColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: SizeConfig().textSize(context, 2)),
                            ),
                          ),
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
                              : LoginButton(
                                  onPressed: () {
                                    final form = formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      state
                                          .login(
                                        usernameController.text.trim(),
                                        passwordController.text.trim(),
                                      )
                                          .then((value) {
                                        if (value != null) {
                                          Future.delayed(Duration(seconds: 3))
                                              .then((value) => Get.offAll(
                                                  DashboardScreen()));
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
            ),
          );
  }
}
