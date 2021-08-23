import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<Announcement> updatesList = [];

  @override
  void didChangeDependencies() {
    Provider.of<Announcements>(context, listen: false)
        .fetchAndSetAnnouncement();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    updatesList =
        Provider.of<Announcements>(context, listen: false).announcement;
    print('announcements :   $updatesList');
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
