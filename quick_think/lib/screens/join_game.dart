import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:quickthink/model/question_model.dart';
import 'package:quickthink/screens/create_game.dart';
import 'package:quickthink/screens/quiz_page.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:http/http.dart' as http;
import 'package:quickthink/utils/urls.dart';
import 'package:quickthink/widgets/noInternet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/responsiveness/res.dart';

// const String url = 'https://brainteaser.pythonanywhere.com/game/play';
// const String checkUrl =
//     'https://brainteaser.pythonanywhere.com/game/user/play/check';

class JoinGame extends StatefulWidget {
  static const routeName = 'join-game';
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController username = TextEditingController();
  TextEditingController gameCode = TextEditingController();

  ///List to store played gameCodes
  List<String> playedGames = [];

  final _formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;

  ProgressDialog progressDialog;
  //List<String> gamecodes = [value];

//Check Internet Connectivity
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool _connection = false;

  @override
  void initState() {
    //get the played codes
    getPlayedCodes('playedGames');

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
            //startTimer();
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
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => JoinGame()));
        Navigator.pushReplacementNamed(context, 'join-game');
      },
    );
  }

  //Persisting the play GameCodes
  Future<List<String>> savePlayedCodes(String key, List<String> value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final List<String> newList = value;
    List<String> setList = LinkedHashSet<String>.from(newList).toList();
    sharedPreferences.setStringList(key, setList);
    return newList;
  }

  ///Retrieving the Persistent played GameCodes
  Future<List<String>> getPlayedCodes(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final valueStored = sharedPreferences.getStringList(key) ?? [];
    print('List Retrieved with Play Game Codes in Join Game: $valueStored');
    playedGames = valueStored;
  }

  void _showInSnackBar(String value, color) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: color,
      duration: new Duration(seconds: 3),
    ));
  }

  void _showToast(String value, color) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: color,
      duration: new Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context,
        isDismissible: false, type: ProgressDialogType.Normal);

    progressDialog.style(
      message: 'Joining Game',
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

    return _connection
        ? NoInternet()
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                      SizedBox(
                        height: SizeConfig().yMargin(context, 1.7),
                      ),
                      _prompt(),
                      _form(),
                      _loginBtn(),
                      _or(),
                      _createGameLink(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget _or() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig().xMargin(context, 10.0),
        //right: SizeConfig().xMargin(context, 3.0),
      ),
      child: Text(
        '- OR -',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w200,
          fontSize: SizeConfig().textSize(context, 1.5),
        ),
      ),
    );
  }

  Widget _createGameLink() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig().xMargin(context, 6.0),
        //right: SizeConfig().xMargin(context, 3.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateGame()));
        },
        child: Text(
          'Create a game',
          style: GoogleFonts.poppins(
            fontSize: SizeConfig().textSize(context, 3),
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig().yMargin(context, 3.0),
          ),
          _quizCode(),
          SizedBox(
            height: SizeConfig().yMargin(context, 4),
          ),
          _username(),
          SizedBox(
            height: SizeConfig().yMargin(context, 7),
          ),
        ],
      ),
    );
  }

  Widget _prompt() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig().xMargin(context, 5.0),
        right: SizeConfig().xMargin(context, 3.0),
      ),
      child: Text(
        'Enter invite code to join the game',
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: SizeConfig().textSize(context, 3.2),
        ),
      ),
    );
  }

  Widget _logoText() {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: 'Quick',
            style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig().textSize(context, 3),
                color: Colors.white)),
        TextSpan(
            text: 'Think',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig().textSize(context, 3),
              color: Color.fromRGBO(24, 197, 217, 1),
            ))
      ]),
    );
  }

  Widget _username() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig().xMargin(context, 5.0),
        right: SizeConfig().xMargin(context, 3.0),
      ),
      child: TextFormField(
        controller: username,
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 3),
            color: Colors.white),
        onChanged: (val) {},
        validator: (val) {
          if (val.trim().length == 0) {
            return 'Username Should Not Be Empty';
          }
          if (val.trim().length <= 2) {
            return 'should be 3 or more characters';
          }
          if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val.trim())) {
            return "can only include _ or -";
          }
          return null;
        },
        onSaved: (val) => username.text = val,
        decoration: InputDecoration(
          hintText: 'Enter Username',
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig().textSize(context, 2),
              color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
          fillColor: Color.fromRGBO(87, 78, 118, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _quizCode() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig().xMargin(context, 5.0),
        right: SizeConfig().xMargin(context, 3.0),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 3),
            color: Colors.white),
        onChanged: (val) {},
        controller: gameCode,
        validator: (val) {
          if (val.length == 0) {
            return 'Quiz Code Should Not Be Empty';
          }
          if (val.length <= 2) {
            return 'should be 3 or more characters';
          }
          return null;
        },
        onSaved: (val) => gameCode.text = val,
        decoration: InputDecoration(
          hintText: 'Enter Game Code',
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig().textSize(context, 2),
              color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
          fillColor: Color.fromRGBO(87, 78, 118, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _loginBtn() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
      onPressed: () {
        onPressed();
      },
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color.fromRGBO(24, 197, 217, 1),
      highlightColor: Color.fromRGBO(24, 197, 217, 1),
      child: Text('Join Game',
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
      print(gameCode.text + username.text);

      /* List<Question> responseFromFunction = await _joinGame(gameCode.text, username.text);
      if (responseFromFunction != null) {
       
      } */
      progressDialog.show();

      await _joiningGame(gameCode.text.trim(), username.text.trim())
          .then((response) {
        if (response.statusCode == 200) {
          ///Persisting the played gameCodes to sharedprefs
          playedGames.insert(0, gameCode.text);
          print('Here $playedGames');
          progressDialog.hide();
          savePlayedCodes('playedGames', playedGames);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (o) => QuizPage(
                        gameCode: gameCode.text.trim(),
                        userName: username.text.trim(),
                      )));
        } else if (response.statusCode == 400) {
          progressDialog.hide();
          setState(() {
            showError(json.decode(response.body)['error']);
          });
        } else {
          progressDialog.hide();
          setState(() {
            showError(json.decode(response.body)['error']);
          });
        }
      });
    }
  }

  Future showError(String error) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
              height: SizeConfig().getXSize(context, 650),
              width: SizeConfig().getYSize(context, 400),
              padding: EdgeInsets.only(top: SizeConfig().xMargin(context, 5)),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig().xMargin(context, 2)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Icon(
                              FlutterIcons.alert_circle_mco,
                              color: Hexcolor('#FF1F2E'),
                              size: 36.0,
                            ),
                          ),
                        ),
                        // SizedBox(width: 10.0),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Wait a Minute!",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig().textSize(context, 3),
                                color: Hexcolor('#1C1046')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig().getXSize(context, 30)),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig().xMargin(context, 2)),
                      child: Text(
                        error,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: SizeConfig().textSize(context, 2),
                            letterSpacing: 1.0,
                            color: Hexcolor('#1C1046')),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig().getXSize(context, 30)),
                  RaisedButton(
                    //    padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Hexcolor('#18C5D9'),
                    child: Text('OK',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig().textSize(context, 2),
                            color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<http.Response> _joiningGame(code, user) async {
    http.Response response = await http.post(
      checkUrl,
      headers: {'Accept': 'application/json'},
      body: {"game_code": code, "user_name": user},
    );

    return response;
  }

  Future<List<QuestionModel>> _joinGame(code, user) async {
    setState(() {
      progressDialog.show();
    });
    http.Response response = await http.post(
      playGameUrl,
      headers: {'Accept': 'application/json'},
      body: {"game_code": code, "user_name": user},
    );
    print('Params: $code $user');
    print('Status Code Found: ${response.statusCode}');
    if (response.statusCode == 200) {
      String data = response.body;
      List decodedQuestions = jsonDecode(data)['data']['questions'];

      print(decodedQuestions);
      setState(() {
        progressDialog.hide();
      });

      return decodedQuestions
          .map((questions) => new QuestionModel.fromJson(questions))
          .toList()
            ..shuffle();
    } else {
      print('Error Code ${response.statusCode}');
      String data = response.body;
      print(data);
      //   print('Error Ocurres: ${response.body}');
      // String error = jsonDecode(data)['error'];
      // print('Error Decoded: $error');
      setState(() {
        progressDialog.hide();
      });

      _showInSnackBar(
          jsonDecode(data)['error, invalid credentials'], Colors.red);
      return List();
    }
  }
}
