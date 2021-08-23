import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/widgets/column_templete.dart';
import 'package:arcadia/widgets/update_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<UpdateCard> updatesList = [];

  @override
  void didChangeDependencies() {
    Provider.of<Announcements>(context, listen: false).fetchAndSetAnnouncement();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ColumnTemplate(
      columnTitle: 'Updates',
      childWidget: Expanded(
        child: Container(
          child: Text("hdcida"),
        ),
      ),
    ));
  }
}
