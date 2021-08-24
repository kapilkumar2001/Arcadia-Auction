import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/announcement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  AnnouncementCard({required this.announcement});
  

  
  @override
  Widget build(BuildContext context) {

    void _showSimpleDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            titlePadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
            backgroundColor: CustomColors.firebaseNavy,
            title: Text(announcement.title,style: TextStyle(color: Colors.white,fontSize: 36),textAlign: TextAlign.center,),
            
            children: <Widget>[
              Divider(
                color: Colors.white,
                height: 20,
              ),
              Text(announcement.subtitle,textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.white,),),
              SizedBox(height: 20,),
              Text(announcement.desc,textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.underline,fontSize: 22,color: Colors.white,),)
            ],
          );
        });
  }
    
    return Container(
      margin:EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,

        borderRadius: BorderRadius.circular(30)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
           
            border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white),
            
            ),
          ),
          child: Image.asset('assets/arcadia-logo3.png'),
        ),
        tileColor: Colors.grey,
        title: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Column(
              children: [
                Text(
                  announcement.title,
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ],
            )),
        trailing: Text(
          DateFormat('hh:mm dMMM').format(announcement.createddateTime),
          style: TextStyle(color: Colors.white,fontSize: 12),
          textAlign: TextAlign.start,
        ),
        onTap: () {
          _showSimpleDialog();
        },
      ),
    );
    
  }
}
