import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _logoText(),
                Container(
                  child: Form(
                    key: null,
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
                ),
                )
              ],
            ),
          ),
      ),
    );
   
  }

  Widget _imageSelection() {
    return _genericAvatar(1, "assets/images/cat.svg", 45.0, 0.0, 60.0, 0.0, 3.0, 17.0);
  }

  Widget _getItemIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _genericAvatar(1, "assets/images/cat.svg", 35.0, 0.0, 17.0, 6.0, -7.0, 10.0),
        _genericAvatar(2, "assets/images/cocker-spaniel.svg", 35.0, 6.0, 17.0, 6.0, -7.0, 10.0),
        _genericAvatar(3, "assets/images/owl.svg", 35.0, 6.0, 17.0, 6.0, -7.0, 10.0),
        _genericAvatar(4, "assets/images/sheep.svg", 35.0, 6.0, 17.0, 0.0, -7.0, 10.0),

      ],
    );
  }

  Widget _prompt() {
    return Container(
      margin: EdgeInsets.only(top: 22.0),
      child: Text('Selected Preferred avatar',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: Colors.white
        ),
      ),
    );
  }

  Widget _nickName() {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      width: 305.0,
      height: 48.0,
      child: TextFormField(
        style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 20.0,
            color: Colors.white
        ),
        obscureText: false,
        onChanged: (val) {
          setState(() => nick = val);
        },
        decoration: InputDecoration(
          hintText: 'Enter nickname',
          hintStyle: TextStyle(
              fontFamily: 'poppins',
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
      ),
    );
  }
  Widget _loginBtn() {
    return Container(
        margin: EdgeInsets.only(top: 30.0),
        width: 204.0,
        height: 56.0,
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
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: Colors.white
            )
          ),
        )
    );
  }

  Widget _genericAvatar(id, uri, radius, left, top, right, posL, posB) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, top, right, 0.0),
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Color.fromRGBO(56, 32, 140, 1),
              radius: radius,
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
        child: SvgPicture.asset(asset)
      ),
    );
  }



  Widget _logoText() {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      alignment: Alignment.center,
      child: RichText(
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
      ),
    );
  }
}

