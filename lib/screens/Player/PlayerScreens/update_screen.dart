import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/enums/category.dart';
import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/widgets/announcement_card.dart';
import 'package:flutter/material.dart';
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
    print('announcements :   $announcementList');
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Arcadia CSGO League',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height-200,
                    child: ListView(
                    
                      children:[ 
                        ...announcementList.map((e) => AnnouncementCard(announcement:e )).toList(),
                        
                      // ExpansionTile(
                      //   title: Text(
                      //     announcementList[0].title.toString(),
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 22),
                      //   ),
                      //   subtitle: Text(
                      //     announcementList[0].subtitle.toString(),
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 15),
                      //   ),
                      //   children: [
                      //     Text(
                      //       announcementList[0].desc.toString(),
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 15),
                      //     ),
                      //   ],
                      // ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
