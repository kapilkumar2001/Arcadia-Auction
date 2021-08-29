import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/screens/signin_screen.dart';
import 'package:arcadia/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Colors.black,
                Colors.black,
                Colors.black,
                Colors.black,
                // Color(0xFF3594DD),
                // Color(0xFF4563DB),
                // Color(0xFF5036D5),
                // Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    alignment: Alignment.centerRight,
                    child: _currentPage != 2
                        ? FlatButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(SignInScreen.routeName),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        : FlatButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(SignInScreen.routeName),
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          )),
                Container(
                  height: 600.0,
                  // width: MediaQuery.of(context).size.width,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 600.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.asset(
                                      'assets/onboarding.png',
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 3,
                                left: 90,
                                child: Center(
                                  child: Text(
                                    'Make Your Profile',
                                    style: kTitleStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // SizedBox(height: 15.0),
                          // Text(
                          //   'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                          //   style: kSubtitleStyle,
                          // ),
                        ],
                      ),
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 600.0,
                              width: MediaQuery.of(context).size.width,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'assets/onboarding1.png',
                                ),
                              ),
                            ),
                          ),
                          // Image.asset(
                          //   'assets/onboarding1.png',
                          //   height: 600.0,
                          //   width: MediaQuery.of(context).size.width,
                          // ),
                          Positioned(
                            top: 3,
                            left: 70,
                            child: Center(
                              child: Text(
                                'Get Your Match Stats',
                                style: kTitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 600.0,
                              width: MediaQuery.of(context).size.width,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'assets/onboarding2.png',
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/onboarding2.png',
                            height: 650.0,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Positioned(
                            top: -1,
                            left: 60,
                            child: Center(
                              child: Text(
                                'what are you waiting for?',
                                style: kTitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                              onPressed:
                              () => Navigator.of(context)
                                  .pushNamed(SignInScreen.routeName),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Let\'s go',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
