import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
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
                    width: double.infinity,
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
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 100,
                      // child: ListView.builder(
                      //   itemBuilder: (_, index) {
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                  announcementList[0].title,
                                  style: TextStyle(fontSize: 20),
                                )),
                                Flexible(
                                  child: Text(
                                    DateFormat('d, MMM 7:mm').format(
                                        announcementList[0].createddateTime),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              height: 20,
                              color: Colors.black,
                            ),
                            Text(
                              announcementList[0].subtitle,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      )
                      //   },
                      // ),
                      )
                ],
              ),
            ),
          );
  }
}
