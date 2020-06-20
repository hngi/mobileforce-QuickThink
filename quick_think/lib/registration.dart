import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickthink/image.dart';

class Registration extends StatefulWidget {
  Registration({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  File _image;
  final picker = ImagePicker();
  String nick = '';
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(28, 16, 70, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _coloredText(),
                  Form(
                    key: null,
                    child: Container(
                      constraints: BoxConstraints.expand(
                        height: 500.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _imageSelection(),
                          _prompt(),
                          _getItemIcons(),
                          _nickName(),
                          _loginBtn()
                        ],
                      ),
                    )
                  )
                ],
              ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 15.0),
      child: Text('QuickThink',
        style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),
    );
  }

  Widget _imageSelection() {
    return _genericAvatar(1, "assets/images/cat.jpg", 45.0, 0.0, 0.0, 0.0, 20.0);
  }

  Widget _getItemIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _genericAvatar(1, "assets/images/cat.jpg", 35.0, 0.0, 6.0, -5.0, 10.0),
        _genericAvatar(2, "assets/images/cocker-spaniel.jpg", 35.0, 6.0, 6.0, -5.0, 10.0),
        _genericAvatar(3, "assets/images/owl.jpg", 35.0, 6.0, 6.0, -5.0, 10.0),
        _genericAvatar(4, "assets/images/sheep.jpg", 35.0, 6.0, 0.0, -5.0, 10.0),

      ],
    );
  }

  Widget _prompt() {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Text('Selected Preferred avatar',
      style: TextStyle(
        fontSize: 20.0,
          color: Colors.white
      ),
      ),
    );
  }

  Widget _nickName() {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      width: 305,
      height: 48,
      child: TextFormField(
        obscureText: false,
        onChanged: (val) {
          setState(() => nick = val);
        },
        decoration: InputDecoration(
          hintText: 'Enter nickname',
          hintStyle: TextStyle(
              color: Colors.white
          ),
          contentPadding: EdgeInsets.all(7.0),
          fillColor: Color.fromRGBO(87, 78, 118, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(24, 197, 217, 1),
                  width: 1.0),
              borderRadius: BorderRadius.circular(5.0)
          ),
        ),
      ),
    );
  }
  Widget _loginBtn() {
    return Container(
        margin: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        width: 204,
        height: 56,
        child: RaisedButton(
          onPressed: () async {
            print(nick);
          },
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          color: Color.fromRGBO(24, 197, 217, 1),
          highlightColor: Color.fromRGBO(24, 197, 217, 1),
          child: Text('Get started',
            style: GoogleFonts.poppins(
              fontSize: 20.0
            )
          ),
        )
    );
  }

  Widget _genericAvatar(id, uri, radius, left, right, posL, posB) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 20.0, right, 10.0),
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Color.fromRGBO(56, 32, 140, 1),
              radius: radius
            ),
            Positioned(
              left: posL,
              bottom: posB,
              child: _icon(id, uri),
            )
          ],
        ),
    );
  }

  Widget _icon(id, asset) {
//    the id can be used
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
      child: RawMaterialButton(
        elevation: 4.0,
        onPressed: () {},
        padding: EdgeInsets.all(0.0),
        child: Image.asset(asset),
      ),
    );
  }



  Widget _coloredText() {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 15.0),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Quick',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.0,
              )
            ),
            TextSpan(
              text: 'Think',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                color: Colors.cyan
              )
            )
          ]
        ),
      ),
    );
  }
}

