import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quickthink/screens/home.dart';
import 'package:quickthink/screens/leaderboard.dart';
import 'package:quickthink/screens/settings.dart';


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
  final widgetOptions = [Home(), LeaderBoard(), Settings()];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
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
