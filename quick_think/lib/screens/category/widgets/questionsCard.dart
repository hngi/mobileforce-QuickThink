import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/screens/category/screens/create_question.dart';
import 'package:quickthink/screens/category/services/models/questions.dart';
import 'package:quickthink/screens/login/responsiveness/res.dart';
import 'package:quickthink/utils/responsiveness.dart';

class QuestionsCard extends StatelessWidget {
  final Map<String, dynamic> questions;
  final int number;

  const QuestionsCard(
      {Key key, @required this.questions, @required this.number})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      width: McGyver.rsDoubleW(context, 20),
      height: McGyver.rsDoubleH(context, 45),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Question ${number + 1}',
                    style: GoogleFonts.poppins(
                        fontSize: SizeConfig().textSize(context, 2.3),
                        fontWeight: FontWeight.bold),
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
                              fontWeight: FontWeight.bold),
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
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ])
                ],
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 3)),
              Text(
                questions['question'],
                style: GoogleFonts.poppins(
                    fontSize: SizeConfig().textSize(context, 2.1),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 2)),
              Text(
                'Answer choices',
                style: GoogleFonts.poppins(
                    fontSize: SizeConfig().textSize(context, 2.1),
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: McGyver.rsDoubleH(context, 2)),
              Expanded(
                child: Container(
                  // color: Colors.blue,
                  height: McGyver.rsDoubleH(context, 14),
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: Colors.black26,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      '30 sec',
                      style: GoogleFonts.poppins(
                          fontSize: SizeConfig().textSize(context, 1.7),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
