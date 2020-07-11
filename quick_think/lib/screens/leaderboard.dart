import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/model/leaderboard_model.dart';
import 'package:quickthink/theme/theme.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  bool light = CustomTheme.light;

  final model = LeaderboardModel();

  List topUsers;

  @override
  void initState() {
    model.getLeaderboard("1002");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      Duration(minutes: 5),
      refreshBoard
    );
    return Scaffold(
      backgroundColor: light ? Color(0xff1C1046) : Hexcolor('#000000'),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _arrow(),
                _text(),
              ],
            )),
            SizedBox(
              height: 10.0,
            ),
            Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   Container(
                       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: <Widget>[
                           StreamBuilder(
                             stream: model.leaderboardState,
                               builder: (buildContext, snapshot){
                                  if(snapshot.data == fetchState.Busy){
                                    return SpinKitFoldingCube(
                                      color: Colors.white,
                                      size: 20.0,
                                    );
                                  }
                                  if(snapshot.hasError || snapshot.data == fetchState.NoData){
                                    return Error(snapshot.error);
                                  }
                                  return ListView.builder(
                                    itemCount: 3,
                                      itemBuilder: (buildContext,index){
                                        if(index == 0){
                                          topUsers[1] = model.listUsers[index];
                                          return SpinKitFoldingCube(
                                            color: Colors.white,
                                            size: 20.0,
                                          );
                                        }
                                        if(index == 1){
                                          topUsers[0] = model.listUsers[index];
                                          return SpinKitFoldingCube(
                                            color: Colors.white,
                                            size: 20.0,
                                          );
                                        }
                                        if(index == 2){
                                          topUsers[2] = model.listUsers[index];
                                        }
                                        return ListView.builder(
                                          itemCount: 3,
                                            itemBuilder: (buildContext,index){
                                              if(index == 1){
                                                return _roundContainer1(topUsers[index].name,light);
                                              }else {
                                                return _roundContainer(
                                                    index.toString(),
                                                    topUsers[index].name,
                                                    light);
                                              }
                                            }
                                        );
                                      }
                                  );
                               }
                           ),
                         ],
                       )),
                   SizedBox(
                     height: 30.0,
                   ),
                   SingleChildScrollView(
                     child: _resultContainer(light,context,model),
                   )
                 ],
               ),
             )
          ],
        ),

      ),
    );

  }

  void refreshBoard(Timer timer) {
    setState(() {
      model.getLeaderboard("1002");
    });
  }
}

Widget _arrow() {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Icon(
        Icons.keyboard_arrow_left,
        color: Colors.white,
        size: 30,
      ));
}

Widget _text() {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        'Leaderboard',
        style: GoogleFonts.poppins(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ));
}

Widget _roundContainer(String text1, String text2, bool light) {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
              backgroundColor: light ? Color(0xff574E76) : Hexcolor('#2B2B2B'),
              radius: 30,
              child: Text(text1,
                  style:
                      GoogleFonts.poppins(fontSize: 16, color: Colors.white))),
          SizedBox(height: 10),
          Text(text2,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white))
        ],
      ));
}

Widget _roundContainer1(String text1, light) {
  return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
              backgroundColor: light ? Color(0xff574E76) : Hexcolor('#2B2B2B'),
              radius: 50,
              child: SvgPicture.asset('images/trophy.svg')),
          Text(text1,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white))
        ],
      ));
}

Widget _resultContainer(bool light,BuildContext context, LeaderboardModel model) {
  final vModel = model;
  return Container(
    alignment: Alignment.center,
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.fromLTRB(30,5,30,20),
          decoration: BoxDecoration(
            color: light ? Colors.white : Hexcolor('#171717'),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            children: <Widget>[
              StreamBuilder(
                  stream: vModel.leaderboardState,
                  builder: (buildContext, snapshot){
                    if(snapshot.data == fetchState.Busy){
                      return SpinKitFoldingCube(
                        color: Colors.white,
                        size: 20.0,
                      );
                    }
                    if(snapshot.hasError || snapshot.data == fetchState.NoData){
                      return Error(snapshot.error);
                    }
                    return ListView.builder(
                        itemCount: vModel.listUsers.length,
                        itemBuilder: (buildContext,index){
                          if(index == 1){
                            return _row('images/cup.svg', 'images/face1.png', 'images/coin2.svg',
                                vModel.listUsers[index].name, vModel.listUsers[index].score.toString(),light);
                          }else{
                            return _row1(index.toString(), 'images/face2.png', 'images/coin2.svg', vModel.listUsers[index].name,
                                vModel.listUsers[index].score.toString(),light);
                          }
                        }
                    );
                  }
              )
            ],
          ));
}

Widget _row(
    String image1, String image2, String image3, String text1, String text2,bool light) {
  return Container(
    padding: EdgeInsets.only(top: 40),
    child: Row(
      children: <Widget>[
        SvgPicture.asset(image1),
        SizedBox(width: 10),
        Image.asset(image2, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text1, style: GoogleFonts.poppins(
            fontSize: 14,
          color: light ? Color(0xff1C1046) : Colors.white
        )
        ),
        Spacer(),
        SvgPicture.asset(image3, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text2, style: GoogleFonts.poppins(
            fontSize: 14,
          color: light ? Color(0xff1C1046) : Colors.white,
        )),
      ],
    ),
  );
}

Widget _row1(
    String text, String image2, String image3, String text1, String text2,bool light) {
  return Container(
    padding: EdgeInsets.only(top: 40),
    child: Row(
      children: <Widget>[
        Text(text, style: GoogleFonts.poppins(fontSize: 14)),
        SizedBox(width: 20),
        Image.asset(image2, width: 20, height: 20),
        SizedBox(width: 13),
        Text(text1, style: GoogleFonts.poppins(fontSize: 14)),
        Spacer(),
        SvgPicture.asset(image3, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text2, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    ),
  );
}

Widget Error(String error){
  return Center(
    child: Text(error, style: GoogleFonts.poppins(fontSize: 14))
  );
}
