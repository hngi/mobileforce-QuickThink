import 'package:flutter/material.dart';
import 'package:quickthink/screens/results.dart';

class IQEnds {
  final username;
  final double totalScore;

  IQEnds({this.username, this.totalScore});

  showEndMsg(context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          title: Text(
            'Hi $username',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
              'You have successfully completed the test proceed for the result',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Proceed',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => Result(
                          score: totalScore.toString(),
                          name: username,
                        )));
              },
            ),
          ],
        );
      },
    );
  }
}