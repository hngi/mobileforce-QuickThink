import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/category/services/utils/animations.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/screens/login/services/utils/snackbar.dart';

import 'package:quickthink/utils/responsiveness.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quickthink/widgets/noInternet.dart';

import 'create_question.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';

const List<Key> keys = [
  Key("Network"),
  Key("NetworkDialog"),
  Key("Flare"),
  Key("FlareDialog"),
  Key("Asset"),
  Key("AssetDialog")
];

class CreatedCategories extends StatefulHookWidget {
  static const routeName = 'created_categories';
  @override
  _CreatedCategoriesState createState() => _CreatedCategoriesState();
}

class _CreatedCategoriesState extends State<CreatedCategories> {
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
            // startTimer();
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
        Navigator.pushReplacementNamed(context, 'created_categories');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final state = useProvider(apiState);
    return _connection
        ? NoInternet()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                  left: SizeConfig().xMargin(context, 5.0),
                  right: SizeConfig().xMargin(context, 5.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig().yMargin(context, 2),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          color: buttonColor,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig().yMargin(context, 2),
                      ),
                      _prompt(),
                      SizedBox(
                        height: SizeConfig().yMargin(context, 4),
                      ),
                      Container(
                          width: width,
                          height: height,
                          child: FutureBuilder(
                              future: state.getUserCategory(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.none &&
                                    snapshot.hasData == null) {
                                  return Container();
                                }
                                return snapshot.hasData
                                    ? snapshot.data.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context, index) {
                                              return Dismissible(
                                                background:
                                                    slideRightBackground(),
                                                confirmDismiss:
                                                    (direction) async {
                                                  if (direction ==
                                                      DismissDirection
                                                          .startToEnd) {
                                                    final bool res =
                                                        await showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                AssetGiffyDialog(
                                                                  key: keys[5],
                                                                  buttonOkColor:
                                                                      buttonColor,
                                                                  image: Image
                                                                      .asset(
                                                                    'assets/images/giphy.gif',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  title: Text(
                                                                    'Are you sure you want to delete this Category?',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: SizeConfig().textSize(
                                                                            context,
                                                                            3),
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  entryAnimation:
                                                                      EntryAnimation
                                                                          .BOTTOM,
                                                                  description:
                                                                      Text(
                                                                    'This action is permanent. Category cannot be recovered',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: SizeConfig().textSize(
                                                                            context,
                                                                            2),
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                                  ),
                                                                  onOkButtonPressed:
                                                                      () {
                                                                    state
                                                                        .deleteCategory(snapshot.data[index]
                                                                            [
                                                                            'name'])
                                                                        .then(
                                                                            (value) {
                                                                      if (value !=
                                                                          null) {
                                                                        snapshot
                                                                            .data
                                                                            .removeAt(index);
                                                                        Navigator.pop(
                                                                            context);
                                                                      } else {
                                                                        print(
                                                                            value);

                                                                        SnackBarService
                                                                            .instance
                                                                            .showSnackBarError("Cannot delete the category .Some players have played the game");
                                                                      }
                                                                      Navigator.pop(
                                                                          context);
                                                                    });
                                                                  },
                                                                ));
                                                    return res;
                                                  } else {}
                                                },
                                                key: Key(index.toString()),
                                                child: FadeIn(
                                                  delay: index - 0.3,
                                                  child: _cards(
                                                      game: snapshot.data[index]
                                                          ['name'],
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => CreateQuestion(
                                                                    questionState:
                                                                        QuestionState
                                                                            .Adding,
                                                                    categoryName:
                                                                        snapshot.data[index]
                                                                            [
                                                                            'name'])));
                                                      }),
                                                ),
                                              );
                                            },
                                          )
                                        : Center(
                                            child: Text(
                                            'No created category',
                                            style: GoogleFonts.poppins(
                                                color: buttonColor,
                                                fontSize: SizeConfig()
                                                    .textSize(context, 2.8)),
                                          ))
                                    : Center(
                                        child: CircularProgressIndicator());
                              }))
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _prompt() {
    return Text(
      'Created categories',
      style: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig().textSize(context, 3.7),
      ),
    );
  }

  Widget _cards({String game, GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: Color(0xff38208C),
          child: Container(
            // height: McGyver.rsDoubleH(context, 13),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                // mainAxisSize: MainAxisSize.min,
                title:
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    Text(
                  '$game category',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig().textSize(context, 2.3),
                  ),
                ),
                //   SizedBox(height: 5)
                // ],
                // ),
                subtitle: Text(
                  '>>> Slide to delete',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white24,
                    //fontWeight: FontWeight.w600,
                    fontSize: SizeConfig().textSize(context, 2),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget _cards1() {
    return Card(
        color: Color(0xff38208C),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: <Widget>[
              Text(
                'French category',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig().textSize(context, 2),
                ),
              ),
              Spacer(),
              Text(
                '1 day ago',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  //fontWeight: FontWeight.w600,
                  fontSize: SizeConfig().textSize(context, 2),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _loginBtn() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
      onPressed: () {
        //onPressed();
        Navigator.pushNamed(context, CreateQuestion.routeName);
      },
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      color: Color.fromRGBO(24, 197, 217, 1),
      highlightColor: Color.fromRGBO(24, 197, 217, 1),
      child: Text('Save',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.white)),
    );
  }

  Widget _promptCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Category',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig().textSize(context, 2.2),
          ),
        ),
      ],
    );
  }
}
