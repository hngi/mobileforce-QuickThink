import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:quickthink/model/categories.dart';
import 'package:quickthink/screens/join_game.dart';
import 'package:quickthink/screens/new_leaderboard.dart';
import 'package:quickthink/theme/theme.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:http/http.dart' as http;
import 'package:quickthink/utils/urls.dart';
import 'package:quickthink/widgets/noInternet.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/responsiveness/res.dart';

class CreateGame extends StatefulWidget {
  static const routeName = 'create_game';
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  List<DropdownMenuItem<Categories>> _dropDownMenuItems;
  List<Categories> getListCategories;
  bool isCategoryLoading = false;
  Categories _selectedCategory;

  Services services = new Services();

  ///ist to store creted gameCodes
  List<String> gamesCreated = [];

  //GetCategories getCategories = new GetCategories();
  bool light = CustomTheme.light;

  final _formKey = GlobalKey<FormState>();

  ProgressDialog progressDialog;

  List<Categories> listCategories = [];
  Future getCat;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  SizeConfig _sizeConfig;
  String userName = '';
  String category;
  String hintText;
  String gameCode;
  TextEditingController userNameController = TextEditingController();
  Future categories;

  //Check Internet Connectivity
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool _connection = false;

  ///Persisting the Created GameCodes
  Future<List<String>> saveCreatesCodes(String key, List<String> value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final List<String> newList = value;
    List<String> setList = LinkedHashSet<String>.from(newList).toList();
    sharedPreferences.setStringList(key, setList);
    return newList;
  }

  ///Retriving the persisted Created GameCodes
  Future<List<String>> getCreatedCodes(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final valueStored = sharedPreferences.getStringList(key) ?? [];
    print('List Retrieved with Create Game Codes in Create Game: $valueStored');
    gamesCreated = valueStored;
  }

  Future _fetchCategory() async {
    listCategories = await services.getCategories();
  }

  Future _fetchCat() async {
    setState(() {
      isCategoryLoading = true;
    });
    getListCategories = await services.getCategories();
    _dropDownMenuItems = buildDropMenuItems(getListCategories);
    _selectedCategory = _dropDownMenuItems[0].value;
    setState(() {
      if (!mounted) return;
      isCategoryLoading = false;
    });
  }

  List<DropdownMenuItem<Categories>> buildDropMenuItems(List categories) {
    List<DropdownMenuItem<Categories>> items = List();
    for (Categories categorys in categories) {
      items.add(
        DropdownMenuItem(
          value: categorys,
          child: Text(categorys.name),
        ),
      );
    }
    return items;
  }

  onChangedDropdownnItem(Categories selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
      category = _selectedCategory.name.toString();
      //
      print('Category: $category');
      //   onSelect(categoryNames.name.toString());
    });
  }

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

    //get the created codes
    getCreatedCodes('createdGames');
    userNameController.addListener(() {});
    super.initState();
    categories = _fetchCategory();
    getCat = services.getCategories();
    _fetchCat();
  }

  @override
  void dispose() {
    subscription.cancel();
    userNameController.dispose();
    super.dispose();
  }

//Navigate to Page When Connectivity is back
  startTimer() async {
    return new Timer(
      Duration(milliseconds: 500),
      () {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => CreateGame()));
        Navigator.pushReplacementNamed(context, 'create_game');
      },
    );
  }

  Future<String> getCode(context, username) async {
    http.Response response = await http.post(
      fetchGameCodeApi,
      headers: {'Accept': 'application/json'},
      body: {
        "user_name": userName,
        "category": '${_selectedCategory.name.toString()}'
      },
    );

    if (response.statusCode == 200) {
      String data = response.body;
      gameCode = jsonDecode(data)['game_code'].toString();

      //Persisting the Created GameCodes
      gamesCreated.insert(0, gameCode);
      saveCreatesCodes('createdGames', gamesCreated);
      return gameCode;
    } else {
      //  throw Exception('Failed to retrieve code');
      print('Status Code: ${response.statusCode}');
      print('Respinse From API: ${response.body}');
      return null;
    }
  }

  shareCode(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    // placeholder for the result

    String code = gameCode;

    String subject = "QuickThink App Score";
    String summary = 'Use this code to play my game: $code';
    Share.share(summary,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context,
        isDismissible: false, type: ProgressDialogType.Normal);

    progressDialog.style(
      message: 'Creating Game ...',
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        /* SizedBox(
                          height: SizeConfig().yMargin(context, 10),
                        ),
                        _logoText(), */
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
                          height: SizeConfig().yMargin(context, 4),
                        ),
                        _prompt(),
                        SizedBox(
                          height: SizeConfig().yMargin(context, 4),
                        ),
                        _promptUsername(),
                        _userName(),
                        SizedBox(
                          height: SizeConfig().yMargin(context, 7),
                        ),
                        // _promptCategory(),
                        _promptCategorys(),

                        SizedBox(
                          height: SizeConfig().yMargin(context, 1),
                        ),
                        _dropDownCategories(onSelect: (String categoryChosen) {
                          setState(() {
                            category = categoryChosen;
                            print(category);
                          });
                        }),
                        // _allCategories(
                        //   onSelect: (String categoryChosen) {
                        //     setState(() {
                        //       category = categoryChosen;
                        //       print(category);
                        //     });
                        //   },
                        // ),
                        SizedBox(
                          height: SizeConfig().yMargin(context, 4),
                        ),
                        //     _loginBtn(),
                        _allBtns(),
                        SizedBox(
                          height: SizeConfig().yMargin(context, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _prompt() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig().xMargin(context, 5.0),
        right: SizeConfig().xMargin(context, 3.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Create a game',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig().textSize(context, 3.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _promptCategory() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig().xMargin(context, 5.0),
        right: SizeConfig().xMargin(context, 3.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Choose Category',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig().textSize(context, 2.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _allCategories({Function(String option) onSelect}) {
    // [
    //   "Math",
    //   "English",
    //   "HNG",
    //   "Science",
    //   "Art",
    //   "games"
    // ];
    return FutureBuilder(
      future: getCat,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 16.0,
              children: List.generate(
                listCategories.length,
                (index) {
                  Categories categoryNames = listCategories[index];
                  return GestureDetector(
                    onTap: () {
                      onSelect(categoryNames.name.toString());
                      Flushbar(
                        titleText: Text(
                          "Category Selected",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        messageText: Text(
                          categoryNames.name.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        icon: Icon(
                          FlutterIcons.select1_ant,
                          size: 20,
                          color: Colors.white,
                        ),
                        leftBarIndicatorColor: Color(0xFF18C5D9),
                        duration: Duration(milliseconds: 2000),
                      )..show(context);
                    },
                    child: Chip(
                      backgroundColor: Color(0xFF38208C),
                      label: Text(
                        categoryNames.name.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig().textSize(context, 2.2),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return Center(
          child: SpinKitThreeBounce(
            color: Color(0xFF18C5D9),
            size: 25,
          ),
        );
      },
    );
    //Check if list is not empty
    // : listCategories.isEmpty
    //     ? Center(
    //         child: SpinKitThreeBounce(
    //           color: Color(0xFF18C5D9),
    //           size: 25,
    //         ),
    //       )
    //     :
    // Padding(
    //     padding: const EdgeInsets.only(left: 6.0),
    //     child: Wrap(
    //         direction: Axis.horizontal,
    //         spacing: 16.0,
    //         children: List.generate(listCategories.length, (index) {
    //           Categories categoryNames = listCategories[index];
    //           return GestureDetector(
    //             onTap: () {
    //               onSelect(categoryNames.name.toString());
    //             },
    //             child: Chip(
    //               backgroundColor: Color(0xFF38208C),
    //               label: Text(
    //                 categoryNames.name.toString(),
    //                 textAlign: TextAlign.start,
    //                 style: TextStyle(
    //                   fontFamily: 'Poppins',
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: SizeConfig().textSize(context, 2.2),
    //                 ),
    //               ),
    //             ),
    //           );
    //         })),
    //   );
  }

  Widget _logoText() {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: 'Quick',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig().textSize(context, 2.5),
                color: Colors.white)),
        TextSpan(
            text: 'Think',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig().textSize(context, 2.5),
              color: Color.fromRGBO(24, 197, 217, 1),
            ))
      ]),
    );
  }

  Widget _userName() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig().xMargin(context, 5.0),
        right: SizeConfig().xMargin(context, 3.0),
      ),
      child: TextFormField(
        controller: userNameController,
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 3),
            color: Colors.white),
        validator: (val) {
          if (val.trim().length == 0) {
            return 'Quiz Name Should Not Be Empty';
          }
          if (val.trim().length <= 2) {
            return 'should be 3 or more characters';
          }
          if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val.trim())) {
            return "can only include _ or -";
          }

          return null;
        },
        onSaved: (val) => userName = val,
        decoration: InputDecoration(
          hintText: 'Enter your username',
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
        left: SizeConfig().xMargin(context, 2.0),
        right: SizeConfig().xMargin(context, 2.0),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: TextEditingController(text: hintText),
        enabled: false,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig().textSize(context, 3),
            color: Colors.black),
        decoration: InputDecoration(
          hintText: '',
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig().textSize(context, 2),
              color: Colors.black),
          contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
          fillColor: Color(0xFFDADADA),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _promptCategorys() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig().xMargin(context, 5.0),
        right: SizeConfig().xMargin(context, 3.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            ' Category',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig().textSize(context, 2.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _promptUsername() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig().xMargin(context, 5.0),
        right: SizeConfig().xMargin(context, 3.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            ' User name',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig().textSize(context, 2.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createBtn() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      onPressed: onPressed,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color.fromRGBO(24, 197, 217, 1),
      highlightColor: Color.fromRGBO(24, 197, 217, 1),
      child: Text('Create ',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig().textSize(context, 2),
              color: Colors.white)),
    );
  }

  Widget _cancelBtn() {
    return FlatButton(
      ///padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
      onPressed: () {
        //Go back to Homepage
        Navigator.pop(context);
        //    print('Category ${_selectedCategory.name}');
      },
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Theme.of(context).primaryColor,
      child: Text('Cancel',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig().textSize(context, 2),
              color: Colors.white)),
    );
  }

  Widget _allBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(child: _cancelBtn()),
        Flexible(child: _createBtn()),
      ],
    );
  }

  Widget _dropDownCategories({Function(String option) onSelect}) {
    return isCategoryLoading
        ? Center(
            child: SpinKitThreeBounce(
              color: Color(0xFF18C5D9),
              size: 25,
            ),
          )
        : Container(
            margin: EdgeInsets.only(
              left: SizeConfig().xMargin(context, 5.0),
              right: SizeConfig().xMargin(context, 3.0),
            ),
            color: Color(0xFF574E76),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Select Category',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: SizeConfig().textSize(context, 2),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  DropdownButton(
                    dropdownColor: Color(0xFF574E76),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: SizeConfig().textSize(context, 2),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                    ),
                    iconEnabledColor: Colors.white,
                    items: _dropDownMenuItems,
                    value: _selectedCategory,
                    onChanged: onChangedDropdownnItem,
                  ),
                ],
              ),
            ),
          );
  }

  Widget _loginBtn() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
      onPressed: onPressed,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color.fromRGBO(24, 197, 217, 1),
      highlightColor: Color.fromRGBO(24, 197, 217, 1),
      child: Text('Create Game',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig().textSize(context, 2),
              color: Colors.white)),
    );
  }

  void _showInSnackBar(String value, color) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: color,
      duration: new Duration(seconds: 3),
    ));
  }

  void onPressed() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      if (_selectedCategory.name.toString() == null) {
        _showInSnackBar('Choose Category from dropdown', Colors.red);
      }
      form.save();
      setState(() {
        progressDialog.show();
      });

      hintText = await getCode(userName.trim(), category);

      setState(() {
        progressDialog.hide();
      });
      //showQuizCodeBottomSheet(context);
      alertDialog(context);
    }

    userNameController.clear();
    category = null;
  }

  alertDialog(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // var heightBox = height * .50;
    // var widthBox = width * .872;
    // return Scaffold(
    //   backgroundColor: Colors.transparent,//Hexcolor('00FFFFFF'),
    //   body: Stack(
    //
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(.0)),
            child: Container(
              height: 350,
              child: Container(
                padding: EdgeInsets.all(22),
                height: 269,
                child: Column(
                  children: <Widget>[
                    smallLine(),
                    SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        Text(
                          "Game Code",
                          style: GoogleFonts.poppins(
                            color: light ? Color(0xff1C1046) : Colors.white,
                            fontSize: SizeConfig().textSize(context, 2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 21),
                    _quizCode(),
                    // why not use screen util
                    //lol I am using a custom class for responsiveness
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.maxFinite,
                      height: 45,
                      child: RaisedButton(
                        color: Color(0xff18C5D9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          Clipboard.setData(new ClipboardData(text: hintText));
                          shareCode(context);
                          //Share Code here
                        },
                        child: Text(
                          "Share game code",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.maxFinite,
                      height: 45,
                      child: RaisedButton(
                        color: Color(0xff18C5D9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          Clipboard.setData(new ClipboardData(text: hintText));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (o) =>
                                      NewLeaderBoard(gameCode: gameCode)));
                          //Flutter Toast
                        },
                        child: Text(
                          "Leaderboard",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  showQuizCodeBottomSheet(BuildContext context) {
    var radius = Radius.circular(10);

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius)),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 269,
          child: Column(
            children: <Widget>[
              smallLine(),
              SizedBox(height: 25),
              Row(
                children: <Widget>[
                  Text(
                    "Game Code",
                    style: GoogleFonts.poppins(
                      color: light ? Color(0xff1C1046) : Colors.white,
                      fontSize: SizeConfig().textSize(context, 2),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 21),
              _quizCode(),
              // why not use screen util
              //lol I am using a custom class for responsiveness
              SizedBox(height: 30),
              SizedBox(
                width: double.maxFinite,
                height: 45,
                child: RaisedButton(
                  color: Color(0xff18C5D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: hintText));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JoinGame(),
                        ));
                    //Flutter Toast
                  },
                  child: Text(
                    "Join game",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget smallLine() {
    return Container(
      height: 3,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: light ? Color(0xff1C1046) : Colors.white,
      ),
    );
  }
}
