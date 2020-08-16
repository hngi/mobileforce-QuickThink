import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/bottom_navigation_bar.dart';
import 'package:quickthink/data/leaderbord_list.dart';
import 'package:quickthink/model/leaderboard_model.dart';
import 'package:quickthink/screens/board_screen.dart';
import 'package:quickthink/screens/join_game.dart';
import 'package:quickthink/screens/quiz_page.dart';
import 'package:quickthink/theme/theme.dart';

class NewLeaderBoard extends StatefulWidget {
  final String gameCode;
  NewLeaderBoard({this.gameCode});
  @override
  _NewLeaderBoardState createState() => _NewLeaderBoardState();
}

class _NewLeaderBoardState extends State<NewLeaderBoard> {
  bool light = CustomTheme.light;
  final model = LeaderboardModel();

  @override
  void initState() {
    model.getLeaderboard(widget.gameCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light ? Color(0xff1C1046) : Hexcolor('#000000'),
      body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints){
              return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Color(0xff1C1046)/* light ? Color(0xff1C1046) : Hexcolor('#000000') */,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  _arrow(context),
                                  _text(widget.gameCode),
                                  _headerContainer(light,context,model)
                                  /*Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: (model.listData == null || model.listData.length == 0) ?
                                    SpinKitFoldingCube(
                                      color: Colors.white,
                                      size: 20.0,
                                    ) :
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                                child: model.listData.length >= 2 ?
                                                _roundContainer('2', model.listData[1].userName, light)
                                                    :
                                                _roundContainer('2', "--", light)
                                            ),
                                            Expanded(
                                              flex: 1,
                                                child: _roundContainer1(model.listData[0].userName, light)
                                            ),
                                            Expanded(
                                              flex: 1,
                                                child: model.listData.length >= 3 ?
                                                _roundContainer('3', model.listData[2].userName, light)
                                                    :
                                                _roundContainer('3', "---", light)
                                            )
                                          ],
                                        )
                                  )*/
                                ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                  color: light ? Colors.white : Hexcolor('#171717'),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30), topRight: Radius.circular(30)
                                ),
                              ),
                              child: _resultContainer(light,context,model),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      )
    );
  }
}
Widget _arrow(context) {
  return InkWell(
    onTap: (){
      Navigator.of(context).pop();
    },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
          size: 30,
        )),
  );
}

Widget _text(String gameCode) {
  return Container(
      padding: EdgeInsets.only(left: 20,right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Leaderboard',
              style: GoogleFonts.poppins(
                  fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: 100.0,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              decoration: BoxDecoration(
                color: Hexcolor("#18C5D9"),
                borderRadius: BorderRadius.circular(7.0)
              ),
              child: Text(
                "Code: $gameCode",
                style: GoogleFonts.poppins(
                    fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
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
  return StreamBuilder(
    stream: model.leaderboardState,
      builder: (context,snapshot){
        if(snapshot.hasError || snapshot.data == fetchState.NoData){
          return Container(
            padding: EdgeInsets.all(20.0),
              child: Center(
                child: Error(snapshot.error),
              )
          );
        }
        if(!snapshot.hasData || snapshot.data == fetchState.Busy){
          return SpinKitFoldingCube(
            color: light ? Color(0xff1C1046) : Colors.white,
            size: 20.0,
          );
        }
        if(model.listData.length == 0){
          return Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                  child: Error("Oops! Your Leaderboard is empty at the moment \nInvite your friends to play and check again")));
        }
        return Container(
          height: 200.0,
          child: ListView.builder(
            shrinkWrap: true,
              itemCount: model.listData.length,
              itemBuilder: (context,index){
                if (index == 0) {
                  return _row(
                      'images/cup.svg', 'images/startl.svg', 'images/coin2.svg',
                      model.listData[index].userName,
                      model.listData[index].score.toString(), light);
                } else {
                  return _row1((index + 1).toString(), 'images/startl.svg',
                      'images/coin2.svg', model.listData[index].userName,
                      model.listData[index].score.toString(), light);
                }
              }
          ),
        );
      }
  );
}

Widget _headerContainer(bool light,BuildContext context, LeaderboardModel model){
  return StreamBuilder(
      stream: model.headerState,
      builder: (context,snapshot){
        if(snapshot.hasError || snapshot.data == fetchState.NoData){
          return Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: _roundContainer('2', "--", light)
                  ),
                  Expanded(
                      flex: 1,
                      child: _roundContainer1("-", light)
                  ),
                  Expanded(
                      flex: 1,
                      child: _roundContainer('3', "---", light)
                  )
                ],
              )
          );
        }
        if(!snapshot.hasData || snapshot.data == fetchState.Busy){
          return Container(
            padding: EdgeInsets.only(top: 30),
            child: SpinKitFoldingCube(
              color: Colors.white,
              size: 20.0,
            ),
          );
        }
        if(model.listData.length == 0){
          return Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: _roundContainer('2', "--", light)
                  ),
                  Expanded(
                      flex: 1,
                      child: _roundContainer1("-", light)
                  ),
                  Expanded(
                      flex: 1,
                      child: _roundContainer('3', "---", light)
                  )
                ],
              )
          );
        }
        return Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: model.listData.length >= 2 ?
                  _roundContainer('2', model.listData[1].userName, light)
                      :
                  _roundContainer('2', "--", light)
              ),
              Expanded(
                  flex: 1,
                  child: _roundContainer1(model.listData[0].userName, light)
              ),
              Expanded(
                  flex: 1,
                  child: model.listData.length >= 3 ?
                  _roundContainer('3', model.listData[2].userName, light)
                      :
                  _roundContainer('3', "---", light)
              )
            ],
          )
        );
      }
  );
}

Widget Error(String error){
  return Center(
      child: Text(error, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xff1C1046)))
  );
}

Widget _row(
    String image1, String image2, String image3, String text1, String text2,bool light) {
  return Container(
    margin: EdgeInsets.only(top: 30),
    padding: EdgeInsets.all(20.0),
    child: Row(
      children: <Widget>[
        SvgPicture.asset(image1),
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
    margin: EdgeInsets.only(top: 30),
    padding: EdgeInsets.all(20.0),
    child: Row(
      children: <Widget>[
        Text(text, style: GoogleFonts.poppins(fontSize: 14)),
        SizedBox(width: 20),
        Text(text1, style: GoogleFonts.poppins(fontSize: 14)),
        Spacer(),
        SvgPicture.asset(image3, width: 20, height: 20),
        SizedBox(width: 10),
        Text(text2, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    ),
  );
}
