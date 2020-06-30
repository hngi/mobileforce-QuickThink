import 'package:flutter/material.dart';

class QuestionView extends StatefulWidget {
  final String difficultyLevel;
  final int numberOfQuestions;

  QuestionView({Key key, @required this.difficultyLevel, this.numberOfQuestions});

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${widget.numberOfQuestions} \n ${widget.difficultyLevel}"),
      ),
    );
  }
}
