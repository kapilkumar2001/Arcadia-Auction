import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/models/models.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/screens/Auction/forms/add_announcement_form.dart';
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
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAnnouncementForm()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 20, 15, 5),
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 14,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            "  Add Announcement",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Center(
              //   child: Text(
              //     "Announcements",
              //     style: TextStyle(
              //         fontSize: 20,
              //         color: Colors.white54,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              ...announcementList
                  .map((e) => AdminAnnouncementCard(announcement: e))
                  .toList(),
            ]),
          );
  }
}
