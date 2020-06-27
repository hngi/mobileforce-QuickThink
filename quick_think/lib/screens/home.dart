import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard.dart';
import 'dashboard.dart';

class Home extends StatelessWidget {

  String _title = "Tiana";
  String welcomeMessage = "Glad you're back";
  String points = "1000";
  String rankPosition = "30th";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1046),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0,35.0,8.0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hello, ",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                letterSpacing: 2.0
                            )
                        ),
                      ),
                      Text(
                        "$_title",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0
                            )
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "$welcomeMessage",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1.0,
                          fontStyle: FontStyle.normal
                        )
                    ),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Color(0xFF38208C),
                    radius: 50,
                    child: Image(
                      image: AssetImage("assets/images/owl 1.png"),
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,8.0,10.0,8.0),
                  child: SizedBox(
                    width: 350,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF574E76),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30,0.0,0,30.0),
                            child: Image(
                                image: AssetImage("assets/coins.png"),
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              title: Text(
                                "$points",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal
                              )
                              ),
                              ),
                              subtitle: Text(
                                 "points",
                                  style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.0,
                                  fontStyle: FontStyle.normal
                                  )
                                ),
                                ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: VerticalDivider(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0.0,0,30.0),
                            child: Image(
                              image: AssetImage("assets/newmedal.png"),
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              title: Text(
                                "$rankPosition",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal
                                    )
                                ),
                              ),
                              subtitle: Text(
                                "Ranking",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 1.0,
                                        fontStyle: FontStyle.normal
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Choose number of questions",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1.0,
                                fontStyle: FontStyle.normal
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      Card(
                        color: Color(0xFF38208C),
                        elevation: 1,
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40,20,180,20),
                            child: Text(
                              "10 questions",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1.0,
                                      fontStyle: FontStyle.normal
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Card(
                        color: Color(0xFF38208C),
                        elevation: 1,
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40,20,180,20),
                            child: Text(
                              "20 questions",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1.0,
                                      fontStyle: FontStyle.normal
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Card(
                        color: Color(0xFF38208C),
                        elevation: 1,
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40,20,180,20),
                            child: Text(
                              "30 questions",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1.0,
                                      fontStyle: FontStyle.normal
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Card(
                        color: Color(0xFF38208C),
                        elevation: 1,
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40,20,180,20),
                            child: Text(
                              "40 questions",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1.0,
                                      fontStyle: FontStyle.normal
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Card(
                        color: Color(0xFF38208C),
                        elevation: 1,
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40,20,180,20),
                            child: Text(
                              "50 questions",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1.0,
                                      fontStyle: FontStyle.normal
                                  )
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF18C5D9).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
            ),
          ],
        ),
        child: FloatingActionButton(
            onPressed: (){
            },
          elevation: 2.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                  FlutterIcons.play_faw5s,
                  color: Colors.white,
                size: 20,
              ),
            ),
          ),
          backgroundColor: Color(0xFF18C5D9),
          hoverColor: Color(0xFF18C5D9)
        ),
      ),
    );
  }
  
}
