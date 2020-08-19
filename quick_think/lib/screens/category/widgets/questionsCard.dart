import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/category/screens/create_question.dart';
import 'package:quickthink/screens/category/services/models/questions.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';
import 'package:quickthink/screens/login/responsiveness/res.dart';
import 'package:quickthink/screens/login/services/enum/enum.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/utils/responsiveness.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const List<Key> keys = [
  Key("Network"),
  Key("NetworkDialog"),
  Key("Flare"),
  Key("FlareDialog"),
  Key("Asset"),
  Key("AssetDialog")
];

class QuestionsCard extends HookWidget {
  final Map<String, dynamic> questions;
  final int number;
  var list;

  QuestionsCard(
      {Key key,
      @required this.list,
      @required this.questions,
      @required this.number})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(questions['options']);
    final state = useProvider(apiState);
    double size = (questions['question'].length +
            questions['options'][0].length +
            questions['options'][1].length +
            questions['options'][2].length +
            questions['options'][3].length) /
        3;
    return Container(
      // color: Colors.white,
      width: McGyver.rsDoubleW(context, 20),
      height: McGyver.rsDoubleH(context, 45) + (size * 1.2),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Question ${number + 1}',
                    style: GoogleFonts.poppins(
                        fontSize: SizeConfig().textSize(context, 2.3),
                        fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Row(children: [
                    Container(
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${questions['category']} category',
                          style: GoogleFonts.poppins(
                              fontSize: SizeConfig().textSize(context, 1.7),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(CreateQuestion(
                          questionState: QuestionState.Editing,
                          question: questions,
                          categoryName: questions['category'],
                        ));
                      },
                      child: Row(
                        children: [
                          Container(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SvgPicture.asset('assets/Vector.svg'),
                          )),
                          Text(
                            'Edit',
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig().textSize(context, 1.9),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ])
                ],
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 3)),
              Expanded(
                flex: 1,
                child: Text(
                  questions['question'],
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: SizeConfig().textSize(context, 2.1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              // SizedBox(height: McGyver.rsDoubleH(context, 0)),
              Text(
                'Answer choices',
                style: GoogleFonts.poppins(
                    fontSize: SizeConfig().textSize(context, 2.1),
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 2)),
              Expanded(
                flex: 2,
                child: SizedBox.expand(
                  // color: Colors.blue,
                  // height: McGyver.rsDoubleH(context, 20),
                  child: ListView.builder(
                      itemCount: questions['options'].length,
                      itemBuilder: (context, index) {
                        var data = questions['options'][index];
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: questions['answer'] == data
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Text(
                                    data,
                                    style: GoogleFonts.poppins(
                                        fontSize:
                                            SizeConfig().textSize(context, 2.1),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  state.buttonState == ButtonState.Pressed
                      ? SpinKitThreeBounce(
                          size: 12,
                          color: buttonColor,
                        )
                      : GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => AssetGiffyDialog(
                                      key: keys[5],
                                      buttonOkColor: buttonColor,
                                      image: Image.asset(
                                        'assets/images/giphy.gif',
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(
                                        'Are you sure you want to delete this question?',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: SizeConfig()
                                                .textSize(context, 3),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      entryAnimation: EntryAnimation.BOTTOM,
                                      description: Text(
                                        'This action is permanent. Question cannot be recovered',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: SizeConfig()
                                                .textSize(context, 2),
                                            fontWeight: FontWeight.w300),
                                      ),
                                      onOkButtonPressed: () {
                                        state
                                            .deleteQuestion(questions['id'],
                                                questions['category'])
                                            .then((value) {
                                          if (value != null) {
                                            list.removeAt(number);
                                            Navigator.pop(context);
                                          }
                                          Navigator.pop(context);
                                        });
                                      },
                                    ));
                          },
                          child: Container(
                            color: Colors.black26,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Delete Question',
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        SizeConfig().textSize(context, 1.7),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                  Spacer(),
                  Container(
                    color: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        '10 sec',
                        style: GoogleFonts.poppins(
                            fontSize: SizeConfig().textSize(context, 1.7),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
