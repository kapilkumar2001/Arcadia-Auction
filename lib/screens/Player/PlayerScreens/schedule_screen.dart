import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule-screen';
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Kapil Yo Yo"),
    );
  }
}
