import 'package:arcadia/provider/announcement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Text(
                  announcement.title,
                  style: TextStyle(fontSize: 20),
                )),
                Flexible(
                  child: Text(
                    DateFormat('hmdMMM')
                        .format(announcement.createddateTime),
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Text(announcement.subtitle,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
