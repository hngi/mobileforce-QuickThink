import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/screens/results.dart';

class IQEnds {
  final username;
  final String message;
  final int totalScore;
  final int questionNumber;

  final String gameCode;

  IQEnds({this.message, this.username, this.totalScore, this.gameCode, this.questionNumber});

  showEndMsg(context) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
    onWillPop: (){
      return;
    }, child:AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          title: Text(
            'Hi $username',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(message,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Proceed',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => Result(
                          score: totalScore,
                          name: username,
                          gameCode: gameCode,
                          questionNumber: questionNumber
                        )));
              },
            ),
          ],
        ));
      },
    );
  }
}
