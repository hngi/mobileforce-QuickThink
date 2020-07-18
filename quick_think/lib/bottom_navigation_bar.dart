import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickthink/screens/leaderboard.dart';
import 'package:quickthink/screens/new_dashboard.dart';
import 'package:quickthink/screens/new_leaderboard.dart';
import 'package:quickthink/screens/settings_view.dart';
//import 'package:quickthink/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
/* void main() => runApp(new BottomNavBar());

//D.dan why another run app?, why not just have bottomnavbar stateful widget?
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Bottom Navigation',
      debugShowCheckedModeBanner: false,
      home: new DashboardScreen(title: 'Bottom Navigation'),

    );
  }
} */

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.username, this.uri}) : super(key: key);
  final String username;
  final String uri;

  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _page = 0;
  String userName, uri;

  @override
  void initState() {
    super.initState();
    this._dataFunction();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
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

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: new PageView(
        children: [
          new DashBoard(uri: uri),
          new NewLeaderBoard(),
          new SettingsView(),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'images/home.svg',
                color: this._page == 0 ? Color(0xff18C5D9) : Colors.white,
              ),
              title: Text('Home',
                  style: TextStyle(
                    color: this._page == 0 ? Color(0xff18C5D9) : Colors.white,
                  ))),
          new BottomNavigationBarItem(
              icon: SvgPicture.asset('images/leader.svg',
                  color: this._page == 1 ? Color(0xff18C5D9) : Colors.white),
              title: Text('Leaderboard',
                  style: TextStyle(
                    color: this._page == 1 ? Color(0xff18C5D9) : Colors.white,
                  ))),
          new BottomNavigationBarItem(
              icon: SvgPicture.asset('images/settings.svg',
                  color: this._page == 2 ? Color(0xff18C5D9) : Colors.white),
              title: Text('Settings',
                  style: TextStyle(
                    color: this._page == 2 ? Color(0xff18C5D9) : Colors.white,
                  ))),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
