import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickthink/screens/board_screen.dart';
import 'package:quickthink/screens/leaderboard.dart';
import 'package:quickthink/screens/new_dashboard.dart';
import 'package:quickthink/screens/new_leaderboard.dart';
import 'package:quickthink/screens/settings_view.dart';
import 'package:quickthink/screens/splashpage.dart';
import 'package:quickthink/utils/notifications_manager.dart';
import 'package:quickthink/widgets/noInternet.dart';
//import 'package:quickthink/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickthink/screens/new_settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboardboard screen';
  DashboardScreen({Key key, this.username, this.uri}) : super(key: key);
  final String username;
  final String uri;

  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _lastSelected = 0;
  PageController _pageController;
  int _page = 0;
  String userName, uri;

  //Check Internet Connectivity
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool _connection = false;

  @override
  void initState() {
//Check Internet Connectivity
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult connectivityResult) {
        _connectionStatus = connectivityResult.toString();
        print(_connectionStatus);
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          if (!mounted) return;
          setState(() {
          //  startTimer();
            _connection = false;
          });
        } else {
          if (!mounted) return;
          setState(() {
            _connection = true;
          });
        }
      },
    );

    super.initState();
    this._dataFunction();
    _pageController = new PageController();
  }

  startTimer() async {
    return new Timer(
      Duration(milliseconds: 500),
      () {
        Navigator.pushReplacementNamed(context, 'dashboardboard screen');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    _pageController.dispose();
  }

  _dataFunction() async {
    if (widget.uri == null || widget.username == null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        userName = sharedPreferences.getString('Username');
        uri = sharedPreferences.getString('Uri');
      });
    } else {
      setState(() {
        userName = widget.username;
        uri = widget.uri;
      });
    }
  }

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetOptions = [
      new DashBoard(uri: uri),
      new BoardScreen(),
      /* new NewSettingsView() */SettingsView(),
    ];
    return _connection
        ? NoInternet()
        : new Scaffold(
            body: Center(
              child: widgetOptions.elementAt(_lastSelected),
            ),
            bottomNavigationBar: FABBottomAppBar(
              color: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              selectedColor: Color(0xff18C5D9),
              onTabSelected: _selectedTab,
              items: [
                FABBottomAppBarItem(imageData: 'images/home.svg', text: 'Home'),
                FABBottomAppBarItem(
                    imageData: 'images/leader.svg', text: 'Leaderboard'),
                FABBottomAppBarItem(
                    imageData: 'images/settings.svg', text: 'Settings'),
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
                  style: TextStyle(color: color, fontFamily: 'inter-regular'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class DashboardScreen extends StatefulWidget {
//   DashboardScreen({Key key, this.username, this.uri}) : super(key: key);
//   final String username;
//   final String uri;

//   @override
//   _DashboardScreenState createState() => new _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   PageController _pageController;
//   int _page = 0;
//   String userName, uri;

//   @override
//   void initState() {
//     super.initState();
//     this._dataFunction();
//     _pageController = new PageController();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _pageController.dispose();
//   }

//   _dataFunction() async {
//     if (widget.uri == null || widget.username == null) {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       setState(() {
//         userName = sharedPreferences.getString('Username');
//         uri = sharedPreferences.getString('Uri');
//       });
//     } else {
//       setState(() {
//         userName = widget.username;
//         uri = widget.uri;
//       });
//     }
//   }

//   void navigationTapped(int page) {
//     // Animating to the page.
//     // You can use whatever duration and curve you like
//     _pageController.animateToPage(page,
//         duration: const Duration(milliseconds: 300), curve: Curves.ease);
//   }

//   void onPageChanged(int page) {
//     setState(() {
//       this._page = page;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: new PageView(
//         children: [
//           new DashBoard(uri: uri),
//           new NewLeaderBoard(),
//           new SettingsView(),
//         ],
//         onPageChanged: onPageChanged,
//         controller: _pageController,
//       ),
//       bottomNavigationBar: new BottomNavigationBar(
//         items: [
//           new BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 'images/home.svg',
//                 color: this._page == 0 ? Color(0xff18C5D9) : Colors.white,
//               ),
//               title: Text('Home',
//                   style: TextStyle(
//                     color: this._page == 0 ? Color(0xff18C5D9) : Colors.white,
//                   ))),
//           new BottomNavigationBarItem(
//               icon: SvgPicture.asset('images/leader.svg',
//                   color: this._page == 1 ? Color(0xff18C5D9) : Colors.white),
//               title: Text('Leaderboard',
//                   style: TextStyle(
//                     color: this._page == 1 ? Color(0xff18C5D9) : Colors.white,
//                   ))),
//           new BottomNavigationBarItem(
//               icon: SvgPicture.asset('images/settings.svg',
//                   color: this._page == 2 ? Color(0xff18C5D9) : Colors.white),
//               title: Text('Settings',
//                   style: TextStyle(
//                     color: this._page == 2 ? Color(0xff18C5D9) : Colors.white,
//                   ))),
//         ],
//         backgroundColor: Theme.of(context).primaryColor,
//         onTap: navigationTapped,
//         currentIndex: _page,
//       ),
//     );
//   }
// }
