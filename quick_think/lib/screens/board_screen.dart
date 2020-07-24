import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/model/board_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_leaderboard.dart';

class BoardScreen extends StatefulWidget {
  static const String id = 'Board screen';
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {

  final model = BoardModel();

  @override
  void initState() {
    model.getCreatedPrefs("createdGames");
    model.getPlayedPrefs("playedGames");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C1046),
      appBar: AppBar(
        title: Text(
          "Board",
          style: GoogleFonts.poppins(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.w500
          )
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints){
                return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight
                      ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Expanded(
                              flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(35.0),
                                  child: Container(
                                    height: 400,
                                    width: 400,
                                    color: Hexcolor("#38208C"),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Games I Played",
                                            style: GoogleFonts.poppins(
                                                fontSize: 28,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            )
                                          ),
                                          Divider(height: 2,color: Colors.white),
                                          resultPlayedPrefs(context,model)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(35.0),
                                child: Container(
                                  height: 400,
                                  width: 400,
                                  color: Hexcolor("#38208C"),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            "Games I Created",
                                            style: GoogleFonts.poppins(
                                                fontSize: 28,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        Divider(height: 2,color: Colors.white),
                                        resultCreatedPrefs(context,model)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          )
      )
    );
  }
}

Widget resultPlayedPrefs(BuildContext context, BoardModel model){
  return StreamBuilder(
    stream: model.playedState,
    builder: (context,snapshot){
      if(snapshot.hasError || snapshot.data == fetchState.NoData){
        return Container(
            margin: EdgeInsets.only(top: 30),
            child: Center(
              child: Error(snapshot.error),
            )
        );
      }
      if(!snapshot.hasData || snapshot.data == fetchState.Busy){
        return SpinKitPouringHourglass(
          color: Colors.white,
          size: 20.0,
        );
      }
      if(model.playedGames.length == 0){
        return Container(
          margin: EdgeInsets.only(top: 30),
          child: Center(
              child: Error("Oops! You have not played any games yet")),
        );
      }
      return Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: model.playedGames.length,
            itemBuilder: (context,index){
              return _row((index + 1).toString(),model.playedGames[index],context);
            }
        ),
      );
    }
  );
}

Widget resultCreatedPrefs(BuildContext context, BoardModel model){
  return StreamBuilder(
      stream: model.createdState,
      builder: (context,snapshot){
        if(snapshot.hasError || snapshot.data == fetchState.NoData){
          return Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Error(snapshot.error),
              )
          );
        }
        if(!snapshot.hasData || snapshot.data == fetchState.Busy){
          return SpinKitPouringHourglass(
            color: Colors.white,
            size: 20.0,
          );
        }
        if(model.createdGames.length == 0){
          return Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                  child: Error("Oops! You have not created any games yet")));
        }
        return Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.createdGames.length,
              itemBuilder: (context,index){
                return _row((index + 1).toString(),model.createdGames[index],context);
              }
          ),
        );
      }
  );
}

Widget Error(String error){
  return Text(error, style: GoogleFonts.poppins(fontSize: 20,color: Colors.white));
}

Widget _row(String index,String gameCode, BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 5.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(index, style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white
              )),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Text(gameCode, style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white
              )),
            ),
            SizedBox(width: 110),
            Expanded(
              flex: 3,
              child: RaisedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (o) =>
                                NewLeaderBoard(gameCode: gameCode)));
                  },
                  color: Hexcolor('#18C5D9'),
                  child: Text(
                      "View",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white
                      ))
              ),
            )
          ],
        ),
        Divider(height: 2,color: Colors.white)
      ],
    ),
  );
}
