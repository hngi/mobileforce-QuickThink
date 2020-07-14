import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerQuiz extends StatefulWidget {
  final Function callBackFunc;
  final bool nextQ;
  final bool endQ;

  TimerQuiz({@required this.nextQ, @required this.endQ, this.callBackFunc});

  @override
  _TimerQuizState createState() => _TimerQuizState();
}

class _TimerQuizState extends State<TimerQuiz> with TickerProviderStateMixin {
  AnimationController controller;

  int get timerSec {
    Duration duration = controller.duration * controller.value;
    return duration.inSeconds;
  }

  double controllerValue() {
    return controller.value;
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '0${duration.inMinutes} : ${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  bool nextQuestion = false;
  bool endQuiz = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10, milliseconds: 900),
    );

    controller.reverse(from: 10).whenComplete(() => widget.callBackFunc());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    nextQuestion = widget.nextQ;
    endQuiz = widget.endQ;
    if (nextQuestion) {
      controller.reset();
      controller.reverse(from: 10).whenComplete(() => widget.callBackFunc());
      nextQuestion = false;
    }
    if (endQuiz) {
      controller.dispose();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Text(
            timerString,
            style: GoogleFonts.poppins(
              color: timerSec > 3 ? Color(0xFFFFFFFF) : Color(0xFFFF4D55),
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          );
        });
  }
}
