import 'package:flutter/material.dart';

class QuestionView extends StatefulWidget {
  final questionNumbers;
  final difficultyLevel;
  QuestionView({@required this.questionNumbers, this.difficultyLevel});
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.questionNumbers.toString() + widget.difficultyLevel.toString())),
    );
  }
}