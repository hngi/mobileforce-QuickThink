import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/category/services/state/apiService.dart';
import 'package:quickthink/screens/category/services/utils/animations.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';

import 'package:quickthink/utils/responsiveness.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'create_question.dart';
import 'package:quickthink/screens/category/services/state/provider.dart';

class CreatedCategories extends StatefulHookWidget {
  static const routeName = 'created_categories';
  @override
  _CreatedCategoriesState createState() => _CreatedCategoriesState();
}

class _CreatedCategoriesState extends State<CreatedCategories> {
  @override
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final state = useProvider(apiState);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: SizeConfig().xMargin(context, 5.0),
            right: SizeConfig().xMargin(context, 5.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig().yMargin(context, 2),
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
                  height: SizeConfig().yMargin(context, 4),
                ),
                _prompt(),
                SizedBox(
                  height: SizeConfig().yMargin(context, 5),
                ),
                Container(
                    width: width,
                    height: height,
                    child: FutureBuilder(
                        future: state.getUserCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.none &&
                              snapshot.hasData == null) {
                            //print('project snapshot data is: ${projectSnap.data}');
                            return Container();
                          }
                          return snapshot.hasData
                              ? snapshot.data.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return FadeIn(
                                          delay: index - 0.3,
                                          child: _cards(
                                              game: snapshot.data[index]
                                                  ['name'],
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateQuestion(
                                                                categoryName:
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'name'])));
                                              }),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                      'No created category',
                                      style: GoogleFonts.poppins(
                                          color: buttonColor, fontSize: SizeConfig().textSize(context, 2.8)),
                                    ))
                              : Center(child: CircularProgressIndicator());
                        }))
                // _cards(),
                // SizedBox(
                //   height: SizeConfig().yMargin(context, 3),
                // ),
                // _cards1()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _prompt() {
    return Text(
      'Created categories',
      style: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig().textSize(context, 3.7),
      ),
    );
  }

  Widget _cards({String game, GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: Color(0xff38208C),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: <Widget>[
                Text(
                  '$game category',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig().textSize(context, 2),
                  ),
                ),
                Spacer(),
                // Text(
                //   '1h ago',
                //   style: TextStyle(
                //     fontFamily: 'Poppins',
                //     color: Colors.white,
                //     //fontWeight: FontWeight.w600,
                //     fontSize: SizeConfig().textSize(context, 2),
                //   ),
                // ),
              ],
            ),
          )),
    );
  }

  Widget _cards1() {
    return Card(
        color: Color(0xff38208C),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: <Widget>[
              Text(
                'French category',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig().textSize(context, 2),
                ),
              ),
              Spacer(),
              Text(
                '1 day ago',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  //fontWeight: FontWeight.w600,
                  fontSize: SizeConfig().textSize(context, 2),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _loginBtn() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
      onPressed: () {
        //onPressed();
        Navigator.pushNamed(context, CreateQuestion.routeName);
      },
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      color: Color.fromRGBO(24, 197, 217, 1),
      highlightColor: Color.fromRGBO(24, 197, 217, 1),
      child: Text('Save',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.white)),
    );
  }

  Widget _promptCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Category',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig().textSize(context, 2.2),
          ),
        ),
      ],
    );
  }
}
