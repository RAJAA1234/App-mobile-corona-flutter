import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {

  final int iconCode;
  final String iconTitle, value;
  final Color color;
  MyCard({@required this.iconCode, @required this.iconTitle, @required this.value, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              iconTitle,
              style: TextStyle(color: this.color, fontSize: 20.0, fontStyle: FontStyle.italic),
            ),
            Icon(
              IconData(iconCode, fontFamily: 'MaterialIcons'),
              color: this.color,
              size: 85.0,
            ),
            Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

}