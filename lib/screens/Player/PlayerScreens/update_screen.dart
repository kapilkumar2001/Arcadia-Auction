import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/widgets/announcement_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<Announcement> announcementList = [];
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Announcements>(context, listen: false)
          .fetchAndSetAnnouncement()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    announcementList =
        Provider.of<Announcements>(context, listen: false).announcement;
    // print('announcements :   $announcementList');
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: CustomColors.firebaseNavy,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      width: MediaQuery.of(context).size.width,
                      // height: 100,
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'Arcadia CSGO League',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          // textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                     Container(
                      decoration: BoxDecoration(
                        
                      ),
                      width: MediaQuery.of(context).size.width,
                      // padding: EdgeInsets.all(30),
                      child: Text(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: CustomColors.firebaseNavy,
                      height: MediaQuery.of(context).size.height - 200,
                      child: ListView(children: [
                        ...announcementList
                            .map((e) => AnnouncementCard(announcement: e))
                            .toList(),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
