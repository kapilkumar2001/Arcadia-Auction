import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Player/PlayerScreens/player_profile_screen.dart';
import 'package:arcadia/screens/Player/PlayerScreens/rules_pdf_viewer.dart';
import 'package:arcadia/widgets/announcement_card.dart';
import 'package:arcadia/widgets/upcoming_match_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:arcadia/provider/match.dart';

import '../../signin_screen.dart';

class PlayerHomeScreen extends StatefulWidget {
  @override
  _PlayerHomeScreenState createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen> {
  List<Announcement> announcementList = [];
  bool _isInit = true;
  bool _isLoading = true;
  int _currentpage = 0;
  List<Match> upcomingMatchList = [];
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];

    for (int i = 0; i < upcomingMatchList.length; i++) {
      list.add(i == _currentpage ? _indicator(true) : _indicator(false));
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
        color: isActive ? Colors.white : CustomColors.firebaseGrey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<Announcements>(context, listen: false)
          .fetchAndSetAnnouncement();

      await Provider.of<Matches>(context, listen: false).fetchAndSetMatches();
      await Provider.of<Teams>(context, listen: false).fetchAndSetTeams();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
  }

  static const IconData my_library_books_outlined =
      IconData(0xf160, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    announcementList =
        Provider.of<Announcements>(context, listen: false).announcement;
    upcomingMatchList =
        Provider.of<Matches>(context, listen: false).upcomingMatches;
    // print('announcements :   $announcementList');
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: CustomColors.primaryColor,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Auth.isAnonymous
                  ? IconButton(
                      onPressed: () async {
                        await Provider.of<Auth>(context, listen: false)
                            .signOut();
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return SignInScreen();
                        }), (route) => false);
                      },
                      icon: Icon(
                        Icons.exit_to_app,
                        size: 30,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(PlayerProfileScreen.routeName);
                      },
                      icon: Icon(
                        FontAwesomeIcons.userCircle,
                        size: 30,
                      ),
                    ),
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RulesPdfViewer.routeName);
              },
              icon: Icon(
                my_library_books_outlined,
                size: 28,
              )),
          centerTitle: true,
          title: Text(
            'CSGO League',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              // textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              // fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: CustomColors.firebaseNavy,
            // padding: EdgeInsets.all(10),
            width: double.infinity,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Upcoming Matches',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  color: CustomColors.firebaseNavy.withOpacity(0.2),
                  margin: EdgeInsets.all(10),
                  height: 200,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentpage = page;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...upcomingMatchList
                          .map((e) => GestureDetector(
                              child: UpcomingMatchCard(match: e)))
                          .toList(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Annoucements',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    // textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: announcementList.isNotEmpty
                      ? ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                              ...announcementList
                                  .map((e) => AnnouncementCard(announcement: e))
                                  .toList(),
                            ])
                      : Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: MediaQuery.of(context).size.width ,
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child:Center(
                            child: Text(
                'No New Announcements :)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
                          ),
            ),
                        ),
              
              ],
            ),
          ),
        ),
      );
    }
  }
}
