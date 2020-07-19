import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

const String register_Api =
    'http://qtapi.theabiolaakinolafoundation.org/api/register';

class Registration extends StatefulWidget {
  static const String id = 'registration screen';
  Registration({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog;
  bool isLoading = false;
  File _image;
  // final picker = ImagePicker();
  String nick = '';
  String password = '';
  String _initUrl = 'cat';
  String pickedUri = '';
  String token = '';
  final _formKey = GlobalKey<FormState>();

  void _showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: Colors.black,
      duration: new Duration(seconds: 3),
    ));
  }

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }

  void handleRegistration(nick, password) async {
    setState(() {
      progressDialog.show();
    });
    http.Response response = await http.post(
      register_Api,
      headers: {'Accept': 'application/json'},
      body: {"name": nick, "password": password},
    );
    if (response.statusCode == 200) {
      String data = response.body;
      token = jsonDecode(data)['data']['token'];

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('Username', nick);
      pref.setString('Password', password);
      pref.setString('Token', token);
      pref.setString("Uri", pickedUri);

      print(response.body);
      setState(() {
        progressDialog.hide();
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(
            username: nick,
            uri: pickedUri,
          ),
        ),
      );
    } else {
      progressDialog.hide();
      _showInSnackBar(response.body);
      print(response.body);
      //TODO: Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context,
        isDismissible: false, type: ProgressDialogType.Normal);

    progressDialog.style(
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: SpinKitThreeBounce(color: Color(0xFF18C5D9), size: 25),
      elevation: 10.0,
      insetAnimCurve: Curves.easeOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40.0),
              _logoText(),
              SizedBox(height: 20.0),
              defaultIcon(_initUrl),
              SizedBox(height: 20.0),
              _prompt(),
              SizedBox(height: 20.0),
              _getItemIcons(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      _nickName(),
                      SizedBox(height: 20.0),
                      _password(),
                      SizedBox(height: 30.0),
                      _loginBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget defaultIcon(_newUrl) {
    _initUrl = _newUrl;
    print('selected is $_initUrl or $_newUrl');
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Color.fromRGBO(56, 32, 140, 1),
            radius: 40.0,
            child: SvgPicture.asset("assets/images/$_initUrl.svg"),
          ),
        ],
      ),
    );
  }

  Widget _getItemIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _genericAvatar("cat", 35.0),
        _genericAvatar("cocker-spaniel", 35.0),
        _genericAvatar("owl", 35.0),
        _genericAvatar("sheep", 35.0),
      ],
    );
  }

  Widget _prompt() {
    return Text(
      'Selected Preferred avatar',
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: Colors.white),
    );
  }

  Widget _nickName() {
    return TextFormField(
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
          color: Colors.white),
      onChanged: (val) {},
      validator: (val) {
        if (val.length == 0) {
          return 'Username Should Not Be Empty';
        }
        if (val.length <= 2) {
          return 'should be 3 or more characters';
        }
        if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val)) {
          return "can only include _ or -";
        }
        return null;
      },
      onSaved: (val) => nick = val,
      decoration: InputDecoration(
        hintText: 'Enter nickname',
        hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 20.0,
            color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
        fillColor: Color.fromRGBO(87, 78, 118, 1),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Widget _password() {
    return TextFormField(
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
          color: Colors.white),
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter password',
        hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 20.0,
            color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
        fillColor: Color.fromRGBO(87, 78, 118, 1),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
      ),
      onChanged: (val) {},
      validator: (val) {
        if (val.length == 0) {
          return 'password cannot Be empty';
        }
        if (val.length <= 4) {
          return "should be more than 4 characters";
        }
        return null;
      },
      onSaved: (pass) => password = pass,
    );
  }

  Widget _loginBtn() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
      onPressed: () {
        setState(() {
          isLoading = true;
        });

        onPressed();
        setState(() {
          isLoading = false;
        });
      },
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color.fromRGBO(24, 197, 217, 1),
      highlightColor: Color.fromRGBO(24, 197, 217, 1),
      child: Text('Get started',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.white)),
    );
  }

  void onPressed() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      handleRegistration(nick, password);
    }
  }

  Widget _genericAvatar(name, radius) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Color.fromRGBO(56, 32, 140, 1),
            radius: radius,
            child: _icon(name),
          ),
        ],
      ),
    );
  }

  Widget _icon(name) {
//    the id can be used
    return RawMaterialButton(
        elevation: 4.0,
        onPressed: () {
          setState(() {
            defaultIcon(name);
            pickedUri = name;
          });
        },
        padding: EdgeInsets.all(0.0),
        child: SvgPicture.asset("assets/images/$name.svg"));
  }

  Widget _loader() {
    return isLoading ? CircularProgressIndicator() : Container();
  }

  Widget _logoText() {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: 'Quick',
            style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: Colors.white)),
        TextSpan(
            text: 'Think',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Color.fromRGBO(24, 197, 217, 1),
            ))
      ]),
    );
  }
}
