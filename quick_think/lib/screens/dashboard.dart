import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickthink/theme/theme.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:quickthink/views/question_view.dart';
import 'package:quickthink/screens/quiz_page.dart';

import 'help.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key, @required this.username, this.uri}) : super(key: key);
  final String username;
  final String uri;

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  // int numberOfQuestions;
  // String option;
  bool light = CustomTheme.light;

  // showDifficultyBottomSheet(BuildContext context) {
  //   var radius = Radius.circular(10);

  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(topLeft: radius, topRight: radius)),
  //     builder: (context) {
  //       return Container(
  //         padding: EdgeInsets.all(22),
  //         height: 360,
  //         child: Column(
  //           children: <Widget>[
  //             smallLine(),
  //             SizedBox(height: 25),
  //             Row(
  //               children: <Widget>[
  //                 Text(
  //                   "Select Difficulty",
  //                   style: GoogleFonts.poppins(
  //                     color: light ? Color(0xff1C1046) : Colors.white,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 Spacer(),
  //                 Container(
  //                   padding: EdgeInsets.all(15),
  //                   decoration: BoxDecoration(
  //                     color: Color(0xffF6F3F3),
  //                     shape: BoxShape.circle,
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Color(0xFF18C5D9).withOpacity(0.5),
  //                         spreadRadius: 2,
  //                         blurRadius: 2,
  //                       ),
  //                     ],
  //                   ),
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       helpAlert(context);
  //                     },
  //                     child: Text(
  //                       "?",
  //                       style: GoogleFonts.poppins(
  //                         color: Color(0xff1C1046),
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 21),
  //             selections(
  //               onSelect: (String option1) {
  //                 setState(() {
  //                   option = option1;
  //                 });
  //                 print(option);
  //               },
  //             ),
  //             SizedBox(height: 48),
  //             SizedBox(
  //               width: double.maxFinite,
  //               height: 45,
  //               child: RaisedButton(
  //                 color: Color(0xff18C5D9),
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(5)),
  //                 onPressed: () {
  //                   if (option != null) {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (o) => QuizPage(
  //                                   gameCode: option,
  //                                   userName: widget.username,
  //                                 )));
  //                   } else {
  //                     Flushbar(
  //                       titleText: Text(
  //                         "Oops!",
  //                         style: GoogleFonts.poppins(
  //                           color: Colors.white,
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                       messageText: Text(
  //                         "Please select a difficulty to start",
  //                         style: GoogleFonts.poppins(
  //                           color: Colors.white,
  //                           fontSize: 12,
  //                         ),
  //                       ),
  //                       icon: Icon(
  //                         FlutterIcons.infocirlceo_ant,
  //                         size: 20,
  //                         color: Colors.white,
  //                       ),
  //                       leftBarIndicatorColor: Color(0xff1C1046),
  //                       duration: Duration(milliseconds: 2000),
  //                     )..show(context);
  //                   }
  //                 },
  //                 child: Text(
  //                   "Start Game",
  //                   style: GoogleFonts.poppins(
  //                     color: Colors.white,
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget smallLine() {
  //   return Container(
  //     height: 3,
  //     width: 35,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(60),
  //       color: light ? Color(0xff1C1046) : Colors.white,
  //     ),
  //   );
  // }

  // Widget selections({Function(String option) onSelect}) {
  //   final List<String> optionsName = ["Easy", "Average", "Hard"];
  //   final List<Color> optionColors = [
  //     Color(0xff86EC88),
  //     Color(0xffFBBD00),
  //     Color(0xffFF4D55)
  //   ];
  //   final List<String> time = ["05:00", "10:00", "20:00"];
  //   return Row(
  //     children: List.generate(
  //       optionsName.length,
  //       (index) {
  //         return Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               onSelect(optionsName[index]);
  //             },
  //             child: Container(
  //               margin: EdgeInsets.symmetric(horizontal: 5),
  //               padding: EdgeInsets.symmetric(vertical: 20),
  //               decoration: BoxDecoration(
  //                 color: optionColors[index],
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               child: Column(
  //                 children: <Widget>[
  //                   Text(
  //                     optionsName[index],
  //                     style: GoogleFonts.poppins(
  //                       color: Colors.white,
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   Text(
  //                     "${time[index]} min",
  //                     style: GoogleFonts.poppins(
  //                       color: Colors.white,
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light ? Color(0xff1c1046) : Hexcolor('#000000'),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF18C5D9).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Color(0xff18C5D9),
          onPressed: () {
            helpAlert(context);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => InfoHelp()));
          },
          child: Text(
            "?",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(14.0, 0, 14.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Hello, ",
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig().textSize(context, 3.2),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: widget.username,
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig().textSize(context, 3.2),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: "Glad you're back",
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig().textSize(context, 2.2),
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),
                      Container(
                        child: CircleAvatar(
                            backgroundColor: Color(0xff38208c),
                            radius: 28.5,
                            child: widget.uri != null
                                ? SvgPicture.asset(
                                    "assets/images/${widget.uri}.svg")
                                : SvgPicture.asset("assets/images/owl.svg")
                            //Image.asset("assets/images/owl 1.png"),
                            ),
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig().yMargin(context, 3)),
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Activity',
                          style: GoogleFonts.poppins(
                              fontSize: SizeConfig().textSize(context, 3),
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: SizeConfig().yMargin(context, 4),
                      ),
                      QuestionSelectionCard(
                        text: 'Join game',
                        onPressed: () {
                          //Navigate to Join Game Page
                        },
                        light: light,
                      ),
                      SizedBox(
                        height: SizeConfig().yMargin(context, 4),
                      ),
                      QuestionSelectionCard(
                        text: 'Customize Game',
                        onPressed: () {
                          //Navigate to Create Game Page
                        },
                        light: light,
                      ),
                      SizedBox(
                        height: SizeConfig().yMargin(context, 4),
                      ),
                      QuestionSelectionCard(
                        text: 'Create questions',
                        onPressed: () {
                          //Navigate to create questions page
                        },
                        light: light,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QuestionSelectionCard extends StatelessWidget {
  final String text;
  final onPressed;
  final light;

  QuestionSelectionCard({@required this.text, this.onPressed, this.light});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: SizeConfig().xMargin(context, 4),
      height: SizeConfig().yMargin(context, 13),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: light ? Color(0xff38208c) : Hexcolor('#4C4C4C'),
        padding: EdgeInsets.fromLTRB(32, 20, 0, 17),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig().textSize(context, 2.3),
                    color: Colors.white))),
        onPressed: onPressed,
      ),
    );
  }
}
