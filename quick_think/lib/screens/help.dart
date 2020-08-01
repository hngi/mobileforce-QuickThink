import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// class InfoHelp extends StatefulWidget {
//   @override
//   _InfoHelpState createState() => _InfoHelpState();
// }

// class _InfoHelpState extends State<InfoHelp> {

var style = GoogleFonts.poppins(
  color: Color(0xFF1C1046),
  fontSize: 14,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
);
var _textStyle = GoogleFonts.poppins(
  color: Color(0xFF1C1046),
  fontSize: 14,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
  // letterSpacing: 0.5,
);
// @override
// Widget build(BuildContext context) {
helpAlert(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  // var heightBox = height * .50;
  // var widthBox = width * .872;
  // return Scaffold(
  //   backgroundColor: Colors.transparent,//Hexcolor('00FFFFFF'),
  //   body: Stack(
  //
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(.0)),
            child: Container(
                height: 350,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 24.0, bottom: 8.0),
                      child: Text(
                        'Help',
                        style: style.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    infoRow(
                      context,
                        "Points are calculated based on number of correct answers given by user. ",
                        'assets/images/coins.png'),
                    infoRow(
                      context,
                        "Each question has a fixed allocated time. Once the time runs out, it moves to the next question. ",
                        'assets/images/clock.png'),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xFF18C5D9),
                      ),
                      height: height * .069,
                      width: width * .368,
                      child: FlatButton(
                        child: Text(
                          'Done',
                          style: style.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                )) //_box(height, width, heightBox, widthBox, context),
            );
      });
}

Widget infoRow(context, String text, String imageUrl) {
  return Container(
    margin: EdgeInsets.only(top:12.0, bottom: 12.0, left: 16.0, right: 16.0),
    child: Row(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: Image.asset(imageUrl, width: 16.0, height: 16.0),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            softWrap: true,
            style: _textStyle.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    ),
  );
}
//}

//This is the widget to be connected to the dashboard screen
// Widget _box(height, width, heightBox, widthBox, BuildContext context) {
//   return Positioned(
//       top: height * .30,
//       bottom: height * .202,
//       left: width * .064,
//       right: width * .064,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           color: light ? Color(0xFFFFFFFF) : Hexcolor('#171717'),
//         ),
//         child: Stack(
//           children: <Widget>[
//             _helpText(heightBox, widthBox),
//             _heplTexts(heightBox, widthBox),
//             _heplTexts2(heightBox, widthBox),
//             _doneBtn(height, width, heightBox, widthBox, context),
//             _icon(heightBox, widthBox),
//             _icon2(heightBox, widthBox),
//           ],
//         ),
//       ));
// }

// Widget _helpText(heightBox, widthBox) {
//   return Positioned(
//     top: heightBox * .13,
//     left: widthBox * .43,
//     bottom: heightBox * .82,
//     child: Text(
//       'Help',
//       style: style.copyWith(
//           fontSize: 20, color: light ? Color(0xFF1C1046) : Colors.white),
//       textAlign: TextAlign.center,
//     ),
//   );
// }

// Widget _heplTexts(heightBox, widthBox) {
//   return Positioned(
//     top: heightBox * .24,
//     left: widthBox * .15,
//     right: widthBox * .15,
//     child: Text(
//       "Points are calculated based on the difficulty level selected. ",
//       style:
//           _textStyle.copyWith(color: light ? Color(0xFF1C1046) : Colors.white),
//       textAlign: TextAlign.justify,
//     ),
//   );
// }

// Widget _heplTexts2(heightBox, widthBox) {
//   return Positioned(
//     top: heightBox * .42,
//     left: widthBox * .15,
//     right: widthBox * .15,
//     child: Text(
//       "Each level has a fixed allocated time that is divided equally among questions",
//       style:
//           _textStyle.copyWith(color: light ? Color(0xFF1C1046) : Colors.white),
//       textAlign: TextAlign.justify,
//     ),
//   );
// }

// Widget _doneBtn(height, width, heightBox, widthBox, BuildContext context) {
//   return Positioned(
//     top: heightBox * .72,
//     left: widthBox * .29,
//     right: widthBox * .29,
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.0),
//         color: Color(0xFF18C5D9),
//       ),
//       height: height * .069,
//       width: width * .368,
//       child: FlatButton(
//         child: Text(
//           'Done',
//           style: style.copyWith(
//             fontWeight: FontWeight.bold,
//             color: light ? Color(0xFFFFFFFF) : Hexcolor('#171717'),
//             fontSize: 16,
//             letterSpacing: 0.5,
//           ),
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//     ),
//   );
// }

// Widget _icon(heightBox, widthBox) {
//   return Positioned(
//     top: heightBox * .43,
//     left: widthBox * .057,
//     right: widthBox * .89,
//     child: CircleAvatar(
//       backgroundImage: AssetImage(
//         'assets/images/medal.png',
//       ),
//       radius: 10.0,
//     ),
//   );
// }

// Widget _icon2(heightBox, widthBox) {
//   return Positioned(
//     top: heightBox * .26,
//     left: widthBox * .057,
//     right: widthBox * .89,
//     child: CircleAvatar(
//       backgroundColor: Colors.transparent,
//       backgroundImage: AssetImage(
//         'assets/images/clock.png',
//       ),
//       radius: 10,
//     ),
//   );
// }
