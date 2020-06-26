import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class Registration extends StatefulWidget {
  static const String id = 'registration screen';
  Registration({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  File _image;
  final picker = ImagePicker();
  String nick = '';
  String password = '';
  String _initUrl = 'cat';
  final _formKey = GlobalKey<FormState>();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )
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
    return Text('Selected Preferred avatar',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: Colors.white
        ),
      );
  }

  Widget _nickName() {
    return TextFormField(
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 20.0,
            color: Colors.white
        ),
        onChanged: (val) {
          setState(() => nick = val);
        },
        validator: (val) {
          if(val.length == 0) {
            return 'Username Should Not Be Empty';
          } 
          if(val.length <=2) {
            return 'should be 3 or more characters';
          }
          if(!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val)) {
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
              color: Colors.white
          ),
          contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
          fillColor: Color.fromRGBO(87, 78, 118, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(24, 197, 217, 1),
                  width: 1.0),
              borderRadius: BorderRadius.circular(5.0)
          ),
        ),
      );
  }
  
  Widget _password() {
    return TextFormField(
      style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 20.0,
            color: Colors.white
        ),
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Enter password',
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: Colors.white
          ),
          contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
          fillColor: Color.fromRGBO(87, 78, 118, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(24, 197, 217, 1),
                  width: 1.0),
              borderRadius: BorderRadius.circular(5.0)
          ),
        ),
      onChanged: (val) {
        setState(() => password = val);
        },
        validator: (val) {
          if(val.length == 0) {
            return 'password cannot Be empty';
          } 
          if(val.length <= 4) {
            return "should be more than 4 characters";
          }
            return null;
        },
      );
  }


  Widget _loginBtn() {
    return RaisedButton(
        padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
        onPressed: onPressed,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        color: Color.fromRGBO(24, 197, 217, 1),
        highlightColor: Color.fromRGBO(24, 197, 217, 1),
        child: Text('Get started',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.white
          )
        ),
      );
  }

  void onPressed() {
    var form = _formKey.currentState;
    if(form.validate()) {
      form.save();
    
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
        });
      },
      padding: EdgeInsets.all(0.0),
      child: SvgPicture.asset("assets/images/$name.svg")
    );
  }



  Widget _logoText() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Quick',
            style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: Colors.white
            )
          ),
          TextSpan(
            text: 'Think',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              color: Color.fromRGBO(24, 197, 217, 1),
            )
          )
        ]
      ),
    );
  }
}
