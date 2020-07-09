import 'statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class CountryItem extends StatefulWidget {
  String countryName, cases;
  String icon;
   Function notification;

  CountryItem(
      {@required this.countryName, @required this.cases, @required this.icon, @required this.notification});

  @override
  createState() => _CountryItem();
}

class _CountryItem extends State<CountryItem> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<String> getCountryFlag() async {
  String url = "https://restcountries.eu/rest/v2/name/" +
        widget.countryName +
        "?fullText=true";
    Response res = await get(url);
    if (res.statusCode == 200) {
      String flag = jsonDecode(res.body)[0]["flag"];

      setState(() {
        widget.icon = flag;
      });
    }

    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getCountryFlag();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: InkWell(
            highlightColor: Colors.greenAccent,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatisticsPage(country: widget.countryName,)
                  )
              );
              //widget.notification();
            },
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 1.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child: Container(
                    height: 85.0,
                    width: 120.0,
                    child: SvgPicture.network(
                      widget.icon,
                      placeholderBuilder: (context) =>
                          CircularProgressIndicator(),
                      height: 85.0,
                      width: 120.0,
                    ),
                  ),
                ),
                title: Text(
                  widget.countryName,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.yellowAccent),
                      onPressed: () {
                        widget.notification();
                      },
                    ),
                    Text(" cases : " + widget.cases,
                        style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing:
                    Icon(Icons.add_alert, color: Colors.white, size: 30.0)),
          ),
        ));
  }
}
