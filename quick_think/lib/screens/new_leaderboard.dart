import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/data/leaderbord_list.dart';
import 'package:quickthink/model/leaderboard_model.dart';
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
  List<User> topUsers;

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
                            color: light ? Color(0xff1C1046) : Hexcolor('#000000'),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  _arrow(),
                                  _text(),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: (model.listUsers == null) ?
                                    SpinKitFoldingCube(
                                      color: Colors.white,
                                      size: 20.0,
                                    ) :
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            _roundContainer('2', model.listUsers[1].name, light),
                                            _roundContainer1(model.listUsers[0].name, light),
                                            _roundContainer('3', model.listUsers[2].name, light)
                                          ],
                                        )
                                  )
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
                              child: _resultContainer(light,context,model,topUsers),
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

Widget _resultContainer(bool light,BuildContext context, LeaderboardModel model,List topUsers) {
  return StreamBuilder(
    stream: model.leaderboardState,
      builder: (context,snapshot){
        if(snapshot.hasError || snapshot.data == fetchState.NoData){
          return Error(snapshot.error);
        }
        if(!snapshot.hasData || snapshot.data == fetchState.Busy){
          return SpinKitFoldingCube(
            color: light ? Color(0xff1C1046) : Colors.white,
            size: 20.0,
          );
        }
        return Container(
          height: 200.0,
          child: ListView.builder(
            shrinkWrap: true,
              itemCount: model.listUsers.length,
              itemBuilder: (context,index){
                if(index == 0){
                  return _row('images/cup.svg', 'images/face1.png', 'images/coin2.svg',
                      model.listUsers[index].name, model.listUsers[index].score.toString(),light);
                }else{
                  return _row1((index + 1).toString(), 'images/face2.png', 'images/coin2.svg', model.listUsers[index].name,
                      model.listUsers[index].score.toString(),light);
                }
              }
          ),
        );
      }
  );
}

Widget Error(String error){
  return Center(
      child: Text(error, style: GoogleFonts.poppins(fontSize: 14))
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
    margin: EdgeInsets.only(top: 30),
    padding: EdgeInsets.all(20.0),
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
