import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickthink/screens/join_game.dart';
//import 'package:quickthink/screens/join_game.dart';
import 'package:quickthink/screens/new_leaderboard.dart';
import 'package:quickthink/share_result/share_result.dart';
import 'package:quickthink/widgets/noInternet.dart';
import 'package:share/share.dart';

class Result extends StatefulWidget {
  static const routeName = 'results_screen';
  final String name;
  final int score;
  final String gameCode;
  final int questionNumber;
  Result({this.name, this.score, this.gameCode, this.questionNumber});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  //Check Internet Connectivity
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool _connection = false;

  var percentageScore;

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
            startTimer();
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
    print('${widget.score} and ${widget.questionNumber}');
    percentageScore = (widget.score / widget.questionNumber) * 100;
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

  shareResult(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    // placeholder for the result
    String subject = "QuickThink App Score";
    String result = '$percentageScore%';
    String questionTotal = widget.questionNumber.toString();
    String appName = 'QuickThink from HNG Tech Limited';
    String resultSummary =
        "Hi, I scored $result out of $questionTotal questions in $appName. Do you think you can beat me? Join me and compete";

    Share.share(resultSummary,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return _connection
        ? NoInternet()
        : Scaffold(
            backgroundColor: Color(0xFF1C1046),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/congrats.svg",
                    ),
                    // update
                    Center(
                      child: Text(
                        "Congrats ${widget.name}!!",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "You Scored:",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 25.0,
                      ),
                      color: Color(0xFF1C1046),
                      shadowColor: Colors.black,
                      elevation: 30.0,
                      child: ListTile(
                        leading: SvgPicture.asset("images/coin.svg"),
                        title: Text(
                          "${widget.score} points",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0,
                            color: Colors.white,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 35.0,
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 18.0,
                      ),
                      color: Colors.white,
                      elevation: 30.0,
                      child: ListTile(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (o) => NewLeaderBoard(
                                      gameCode: widget.gameCode)));
                        },
                        title: Text(
                          "Check leaderboard",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 18.0,
                      ),
                      color: Color(0xFF18C5D9),
                      shadowColor: Colors.black,
                      elevation: 30.0,
                      child: ListTile(
                        title: Text(
                          "New quiz",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(JoinGame.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF18C5D9),
              child: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                shareResult(context);
              },
            ),
          );
  }
}
