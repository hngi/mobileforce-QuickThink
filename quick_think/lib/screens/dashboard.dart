import 'package:flutter/material.dart';
class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1c1046),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff18C5D9),
        onPressed: () {},
        child: Text(
          "?",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(14.0, 0, 14.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Hello, ",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            )),
                        TextSpan(
                            text: "Tiana",
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,

                                fontWeight: FontWeight.bold)),
                        TextSpan(text: '\n'),
                        TextSpan(
                            text: "Glad you're back",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,

                            ),
                        ),
                      ]
                          ),),

                      Container(
                        child: CircleAvatar(
                          backgroundColor: Color(0xff38208c),
                          radius: 28.5,
                          child: Image.asset("assets/images/owl 1.png"),
                        ),
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset("assets/images/Group 23.png"),
                                  SizedBox(width: 2.0,),
                                  Text("1000",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Text("points",
                                  style: TextStyle(
                                    color: Color(0xffdadada),
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                        child: VerticalDivider(
                          thickness: 2.5,
                          color: Color(0xffDADADA),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset("assets/images/medal.png"),
                                    SizedBox(width: 2.0,),
                                    Text("30th",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Text("Ranking",
                                    style: TextStyle(
                                      color: Color(0xffdadada),
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ))
                    ],
                  ),
                )),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Choose number of questions",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                    QuestionSelectionCard(
                      questionNum: 10,
                    ),
                    QuestionSelectionCard(
                      questionNum: 20,
                    ),
                    QuestionSelectionCard(
                      questionNum: 30,
                    ),
                    QuestionSelectionCard(
                      questionNum: 40,
                    ),
                    QuestionSelectionCard(
                      questionNum: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QuestionSelectionCard extends StatelessWidget {
  final questionNum;

  QuestionSelectionCard({@required this.questionNum});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color(0xff38208c),
      padding: EdgeInsets.fromLTRB(32, 20, 0, 17),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "$questionNum questions",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xfffff7e6)),
          )),
      onPressed: () {},
    );
  }
}
