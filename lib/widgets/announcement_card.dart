import 'package:arcadia/provider/announcement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(announcement.title),
      subtitle: Text(announcement.subtitle),
      children: [
        Row(
          children: [
Text(announcement.desc),
            Flexible(
              child: Text(
                DateFormat('hmdMMM').format(announcement.createddateTime),
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        )
      ],
    );
  }
}
