import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:quickthink/screens/home.dart';
import 'package:quickthink/screens/leaderboard.dart';
import 'package:quickthink/screens/settings.dart';

void main() => runApp(new BottomNavBar());

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Bottom Navigation',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFFFFAD32),
      ),
      home: new DashboardScreen(title: 'Bottom Navigation'),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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
      body: new PageView(
        children: [
          new Home(),
          new LeaderBoard(),
          new Settings(),
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
        backgroundColor: Color(0xff1C1046),
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
