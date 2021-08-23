
import 'package:flutter/material.dart';


class ColumnTemplate extends StatelessWidget {

  final String columnTitle;
  final Widget childWidget;

  ColumnTemplate({required this.columnTitle,required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                childWidget,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
