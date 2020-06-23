import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickthink/screens/home.dart';
import 'package:quickthink/screens/leaderboard.dart';
import 'package:quickthink/views/settings_view.dart';

import 'data/new.dart';


class BottomNavBar extends StatefulWidget {
  static const routeName = 'navigation_bar';
  BottomNavBar({Key key, this.title}) : super(key: key);

  String title;
  //String name;

  @override
  _BottomNavBarState createState() => new _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  int _lastSelected = 0;
//static String fname=name;
  final widgetOptions = [Home(), LeaderBoard(), SettingsView()];

  void _selectedTab(int index) {
    showDifficultyBottomSheet(context);

    setState(() {
      _lastSelected = index;
    });
  }

  void showDifficultyBottomSheet(BuildContext context) {
    var radius = Radius.circular(10);
    String option = "easy";
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius)),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 360,
          child: Column(
            children: <Widget>[
              smallLine(),
              SizedBox(height: 25),
              Row(
                children: <Widget>[
                  Text(
                    "Select Difficulty",
                    style: GoogleFonts.poppins(
                      color: Color(0xff1C1046),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Color(0xffF6F3F3), shape: BoxShape.circle),
                    child: Text(
                      "?",
                      style: GoogleFonts.poppins(
                        color: Color(0xff1C1046),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 21),
              selections(
                onSelect: (String option1) {
                  setState(() {
                    option = option1;
                  });
                  print(option);
                },
              ),
              SizedBox(height: 48),
              SizedBox(
                width: double.maxFinite,
                height: 45,
                child: RaisedButton(
                  color: Color(0xff18C5D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (o) => SelectedDiff(title: option)));
                  },
                  child: Text(
                    "Start Game",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget smallLine() {
    return Container(
      height: 3,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Color(0xff1C1046),
      ),
    );
  }

  Widget selections({Function(String option) onSelect}) {
    final List<String> optionsName = ["Easy", "Average", "Hard"];
    final List<Color> optionColors = [
      Color(0xff86EC88),
      Color(0xffFBBD00),
      Color(0xffFF4D55)
    ];
    final List<String> time = ["05:00", "10:00", "20:00"];
    return Row(
      children: List.generate(
        optionsName.length,
            (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                onSelect(optionsName[index]);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: optionColors[index],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      optionsName[index],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${time[index]} min",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_lastSelected),
      ),
      bottomNavigationBar: FABBottomAppBar(
        //centerItemText: 'A',
        color: Colors.white,
        backgroundColor: Color(0xff1C1046),
        selectedColor: Color(0xff18C5D9),
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,

        items: [
          FABBottomAppBarItem(imageData: 'images/home.svg', text: 'Home'),
          FABBottomAppBarItem(
              imageData: 'images/leader.svg', text: 'Leaderboard'),
          FABBottomAppBarItem(imageData: 'images/settings.svg', text: 'Settings'),
        ],
      ),
    );
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.imageData, this.text});
  String imageData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 3);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    //items.insert(items.length >> 1, _buildTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Icon(item.iconData, color: color, size: widget.iconSize),
                SvgPicture.asset(item.imageData, color: color),
                SizedBox(height: 5),
                Text(
                  item.text,
                  style: 
                  GoogleFonts.poppins(fontStyle: FontStyle.normal,color: color),
                 //TextStyle(color: color, fontFamily: 'inter-regular'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
