import 'CountryStatistics.dart';
import 'country_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class CountriesPage extends StatefulWidget {
  @override
  createState() => _CountriesPage();
}

class _CountriesPage extends State<CountriesPage> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  List<CountryStatistics> countries = List();
  List<String> images = List();
  final String url =
      "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php";

  Future<String> getCountries() async {
    var headers = {
      'x-rapidapi-host': 'coronavirus-monitor.p.rapidapi.com',
      'x-rapidapi-key': '5a6d0f2dd4msh8f8a3f2ef05b212p10f6eejsn044cd4de01d8 ',
    };

    Response res = await get(url, headers: headers);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['countries_stat'];

      List<CountryStatistics> data = body
          .map(
            (dynamic item) => CountryStatistics.fromJson(item),
      )
          .toList();

      setState(() {
        countries = data;
      });

      return "Success";
    } else {
      throw "Can't get posts.";
    }
  }

  @override
  void initState() {
    super.initState();
    this.getCountries();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(
        initSettings, onSelectNotification: onSelectNotification );

  }

  Future onSelectNotification(String payload) async {
    debugPrint('print payload : $payload');
    showDialog(context: context,builder: (_)=> AlertDialog(
      title: new Text('Notification') ,
      content: new Text('$payload'),
    ),);
  }

  showNotification() async{
    var android = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription"
        ,priority: Priority.High,importance: Importance.Max);
    var iOS = new IOSNotificationDetails();

    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'country', 'Rajaa mouhib' , platform,payload: 'This is my name');

  }

  @override
  Widget build(BuildContext context) {

    final countryList = countries.map((item) => CountryItem(countryName: item.countryName, cases: item.cases, icon: "aaa", notification: showNotification,)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Corona Alert'),
        backgroundColor: Colors.red[900],
      ),
      body: ListView(
        children: countryList,
      ),
    );
  }

}