import 'package:arcadia/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/match.dart';

class UpcomingMatchCard extends StatelessWidget {
  final Match match;

  const UpcomingMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        
        height: 80,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          // Text('Match ',style: TextStyle(color: Colors.white,fontSize: 30)),
          // Divider(
          //   height: 10,
          // ),
          // Row(children: [

          // ],),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(54, 10, 30, 0),
            child: Row(children: [
              
              Text(match.teamId1,style: TextStyle(color: Colors.white,fontSize: 30),),
              SizedBox(width: 10,),
              Text('VS',style: TextStyle(color: Colors.white),),
              SizedBox(width: 10,),
              Text(match.teamId2,style: TextStyle(color: Colors.white,fontSize: 30)),
            ],),
          ),
          Divider(
            height: 10,
          ),
          Text(
            
            'Live @ '+
          DateFormat('hh:mm dMMM').format(match.matchTime),
          style: TextStyle(color: Colors.white,fontSize: 20),
          textAlign: TextAlign.start,
        ),

        ], ),
        );
    // Container(
    //   // height:100,
    //   // width: 200,
    //   margin:EdgeInsets.fromLTRB(30, 10, 30, 10),
    //   decoration: BoxDecoration(
    //     // color: Colors.red,

    //     borderRadius: BorderRadius.circular(30)
    //   ),
    //   child:ListView(
    //     scrollDirection: Axis.vertical,
    //     children: [
    //       Container(

    //         color: Colors.red,
    //         child: Text(
    //             match.matchId,
    //             style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
    //           ),
    //       ),
    //     ],
    //   )
    //   //  ListTile(
    //   //   contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

    //   //   // leading: Container(
    //   //   //   padding: EdgeInsets.only(right: 12.0),
    //   //   //   decoration: new BoxDecoration(

    //   //   //     border: new Border(
    //   //   //       right: new BorderSide(width: 1.0, color: Colors.white),

    //   //   //     ),
    //   //   //   ),
    //   //   //   child: Image.asset('assets/arcadia-logo3.png'),
    //   //   // ),
    //   //   tileColor: Colors.grey,
    //   //   title: Column(
    //   //     children: [
    //   //       Text(
    //   //         match.matchId,
    //   //         style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
    //   //       ),
    //   //     ],
    //   //   ),
    //   //   // trailing: Text(
    //   //   //   DateFormat('hh:mm dMMM').format(announcement.createddateTime),
    //   //   //   style: TextStyle(color: Colors.white,fontSize: 12),
    //   //   //   textAlign: TextAlign.start,
    //   //   // ),
    //   //   // onTap: () {
    //   //   //   _showSimpleDialog();
    //   //   // },
    //   // ),
    // );
  }
}
