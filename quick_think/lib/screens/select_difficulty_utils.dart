import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/screens/views/question_view.dart';

void showDifficultyBottomSheet(BuildContext context, String questionNumber) {
  String difficultyLevel = '';
  var radius = Radius.circular(10);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius)),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(22),
        height: 360,
        child: Column(
          children: <Widget>[
            smallLine(),
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                Text(
                  "Select Difficulty",
                  style: GoogleFonts.poppins(
                    color: Color(0xff1C1046),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Color(0xffF6F3F3), shape: BoxShape.circle),
                  child: Text(
                    "?",
                    style: GoogleFonts.poppins(
                      color: Color(0xff1C1046),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 21),
            selections(
              onSelect: (String option) {
                difficultyLevel = option;
                print(option);
              },
            ),
            SizedBox(height: 48),
            SizedBox(
              width: double.maxFinite,
              height: 45,
              child: RaisedButton(
                color: Color(0xff18C5D9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionView(questionNumbers: questionNumber, difficultyLevel: difficultyLevel,)));
                },
                child: Text(
                  "Start Game",
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
      color: Color(0xff1C1046),
    ),
  );
}

Widget selections({Function(String option) onSelect}) {
  final List<String> optionsName = ["Easy", "Average", "Hard"];
  final List<Color> optionColors = [
    Color(0xff86EC88),
    Color(0xffFBBD00),
    Color(0xffFF4D55)
  ];
  final List<String> time = ["05:00", "10:00", "20:00"];
  return Row(
    children: List.generate(
      optionsName.length,
          (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              onSelect(optionsName[index]);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: optionColors[index],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    optionsName[index],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${time[index]} min",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
} 