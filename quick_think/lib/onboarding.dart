import 'package:flutter/material.dart';
import 'screens/onboarding_screens/first_onboard_screen.dart';
import 'screens/onboarding_screens/second_onboard_screen.dart';
import 'screens/onboarding_screens/third_onboard_screen.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _pageController;
  int currentIndex = 0;

  final List<Widget> onboardPagesList = <Widget>[
    OnBoardScreen(),
    SecondOnBoardScreen(),
    ThirdOnBoardScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int i){
          return onboardPagesList[i];
        },
        physics: ClampingScrollPhysics(),
        itemCount: onboardPagesList.length,
        controller: _pageController,
        onPageChanged: (int) => print(int),
      
      ),
    );
  }
}
