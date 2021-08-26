import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/screens/Auction/widgets/admin_announcement_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateAnnouncements extends StatefulWidget {
  const UpdateAnnouncements({Key? key}) : super(key: key);

  @override
  _UpdateAnnouncementsState createState() => _UpdateAnnouncementsState();
}

class _UpdateAnnouncementsState extends State<UpdateAnnouncements> {
  List<Announcement> announcementList = [];
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<Announcements>(context, listen: false)
          .fetchAndSetAnnouncement()
          .then((value) => setState(() {
                _isLoading = false;
              }));
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    announcementList =
        Provider.of<Announcements>(context, listen: false).announcement;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Material(
            color: CustomColors.primaryColor,
            child: ListView(children: [
              ...announcementList
                  .map((e) => AdminAnnouncementCard(announcement: e))
                  .toList(),
            ]),
          );
  }
}
