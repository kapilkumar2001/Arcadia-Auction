import 'dart:ui';
import 'package:arcadia/provider/announcement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customDialogBox(context, announcement);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(30)),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/arcadia-logo3.png'),
            Text(
              announcement.title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              DateFormat('hh:mm dMMM').format(announcement.createddateTime),
              style: TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        // child:  ListTile(
        //     contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        //     leading: Container(
        //       padding: EdgeInsets.only(right: 12.0),
        //       decoration: new BoxDecoration(

        //         border: new Border(
        //           right: new BorderSide(width: 1.0, color: Colors.red),

        //         ),
        //       ),
        //       child: Image.asset('assets/arcadia-logo3.png'),
        //     ),
        //     tileColor: Colors.grey,
        //     title: Padding(
        //         padding: EdgeInsets.only(left: 5),
        //         child: Column(
        //           children: [
        //             Text(
        //               announcement.title,
        //               style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        //             ),
        //           ],
        //         )),
        //     trailing: Text(
        //       DateFormat('hh:mm dMMM').format(announcement.createddateTime),
        //       style: TextStyle(color: Colors.white,fontSize: 12),
        //       textAlign: TextAlign.start,
        //     ),
        //     onTap: () {
        //       _showSimpleDialog();
        //     },
        //   ),
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
                            child: new Text(announcement.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                    color: Colors.white)) //
                            ),
                        SizedBox(
                          height: 5.0,
                          width: 5.0,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Text(announcement.subtitle,
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.white)),
                        ) //
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
                          child: new Text(announcement.desc,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ) //
                            ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                    top: 0.0,
                    right: 10.0,
                    child: Icon(
                      Icons.cancel_sharp,
                      size: 30,
                    ),
                  ),
                ],
              )),
        );
      });
}
