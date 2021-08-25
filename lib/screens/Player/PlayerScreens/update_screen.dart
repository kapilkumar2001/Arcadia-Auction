import 'dart:math';

import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/widgets/announcement_card.dart';
import 'package:arcadia/widgets/upcoming_match_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:arcadia/provider/match.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<Announcement> announcementList = [];
  bool _isInit = true;
  bool _isLoading = true;
  List<Match> matchList = [];

  final sugg = [
    'assets/gif.gif',
    'assets/gif1.gif',
    'assets/gif2.gif',
    // 'assets/gif3.gif',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Announcements>(context, listen: false)
          .fetchAndSetAnnouncement()
          .then((value) {
        Provider.of<Matches>(context, listen: false).fetchAndSetMatches();
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  // Future<void> _showDeleteDialog() async {
  //   await showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text('Confirm Delete Team?',
  //           style: TextStyle(
  //               fontWeight: FontWeight.w600,
  //               fontSize: 25,
  //               color: AppTheme.darkGreen)),
  //       content: Text(
  //           '${} and all its associated data will be deleted. This action is irreversible. Are you sure?',
  //           style: kTextStylez4Subtitle),
  //       actions: [
  //         // _buildFlatButton('Delete', 15, _onDelete),
  //         // _buildFlatButton('Cancel', 15, _onCancel),
  //       ],
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(20),
  //         ),
  //       ),
  //       backgroundColor: AppTheme.offWhite,
  //     ),
  //   );
  // }

  static const IconData my_library_books_outlined = IconData(0xf160, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    announcementList =
        Provider.of<Announcements>(context, listen: false).announcement;
    matchList = Provider.of<Matches>(context, listen: false).matches;
    // print('announcements :   $announcementList');
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                 my_library_books_outlined,
                  size: 30,
              ),
                )
              ],
              leading: GestureDetector(
                  child: Icon(
                CupertinoIcons.profile_circled,
                size: 30,
              )),
              centerTitle: true,
              title: Text(
                'Arcadia CSGO League',
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
                child: Column(
                  children: [
                    SizedBox(
                            height: 20,
                          ),
                    // VxSwiper.builder(
                    //   itemCount: sugg.length,
                    //   height: 50.0,
                    //   viewportFraction: 0.35,
                    //   autoPlay: true,
                    //   autoPlayAnimationDuration: 3.seconds,
                    //   autoPlayCurve: Curves.linear,
                    //   enableInfiniteScroll: true,
                    //   itemBuilder: (context, index) {
                    //     // var _random = new Random();
                    //     // index = _random.nextInt(sugg.length);
                    //     final s = sugg[index];
                    //     return Image.asset(s);
                    //   },
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    Container(
                      // height: 200,
                      // width: 200,
                      child: Column(
                        children: [
                          Text(
                            'Upcoming Matches',
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
                            color: CustomColors.firebaseNavy.withOpacity(0.2),
                            margin: EdgeInsets.all(10),
                            height: 200,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ...matchList
                                      .map((e) => GestureDetector(
                                        // onTap: ,
                                        child: UpcomingMatchCard(match: e)))
                                      .toList(),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
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
                          color: CustomColors.firebaseNavy,
                          height: MediaQuery.of(context).size.height / 2,
                          child: ListView(children: [
                            ...announcementList
                                .map((e) => AnnouncementCard(announcement: e))
                                .toList(),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   child: Icon(Icons.library_add),
            //   onPressed: () {},
            // ),
          );
  }
}
