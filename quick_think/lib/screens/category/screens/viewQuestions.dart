import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';
import 'package:quickthink/screens/category/services/utils/animations.dart';
import 'package:quickthink/screens/category/widgets/questionsCard.dart';
import 'package:quickthink/screens/login/responsiveness/res.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/utils/responsiveness.dart';

class ViewQuestions extends StatefulHookWidget {
  @override
  _ViewQuestionsState createState() => _ViewQuestionsState();
}

class _ViewQuestionsState extends State<ViewQuestions> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final state = useProvider(apiState);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig().yMargin(context, 3),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  color: buttonColor,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
              ),
              SizedBox(
                height: SizeConfig().yMargin(context, 1),
              ),
              _prompt(),
              Expanded(
                child: Container(
                  width: width,
                  height: height,
                  child: FutureBuilder(
                      future: state.getUserQuestions(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null) {
                          //print('project snapshot data is: ${projectSnap.data}');
                          return Container();
                        }
                        return snapshot.hasData
                            ? snapshot.data.isNotEmpty
                                ? ListView.separated(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data[index];
                                      var newd = snapshot.data;
                                      return FadeIn(
                                        delay: index - 0.3,
                                        child: QuestionsCard(
                                          questions: data,
                                          number: index,
                                          list: snapshot.data
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: McGyver.rsDoubleH(context, 5),
                                      );
                                    })
                                : Center(
                                    child: Text(
                                    'No Created Questions',
                                    style: GoogleFonts.poppins(
                                      color: buttonColor,
                                      fontSize: SizeConfig().textSize(context, 2.8)
                                    ),
                                  ))
                            : Center(child: CircularProgressIndicator());
                      }),
                ),
              )
            ],
          ),
        ));
  }

  Widget _prompt() {
    return Text(
      'Created Questions',
      style: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig().textSize(context, 3.7),
      ),
    );
  }
}
