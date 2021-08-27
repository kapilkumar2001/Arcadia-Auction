import 'dart:ui';

import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/announcement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminAnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  AdminAnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customDialogBox(context, announcement);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 20, 15, 5),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
          ),
          color: CustomColors.secondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat('hh:mm d MMM').format(announcement.createddateTime),
              style: TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.start,
            ),
            Container(
              width: 220,
              child: Text(
                announcement.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: CircleAvatar(
            //     backgroundColor: Colors.blueAccent,
            //     child: IconButton(
            //       icon: Icon(Icons.edit),
            //       onPressed: () {},
            //       color: Colors.white54,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

customDialogBox(BuildContext context, Announcement announcement) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
              backgroundColor: Colors.white38,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: new Text(
                            announcement.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: new Text(
                              announcement.subtitle,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Divider(
                            color: Colors.white,
                            height: 1.0,
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Text(
                            announcement.desc,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ) //
                            ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: Text(
                              "OK",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 25.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -10.0,
                    right: 0.0,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              )),
        );
      });
}
