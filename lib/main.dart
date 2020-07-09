import 'package:flutterapp1/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'statistics_page.dart';





void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    home:Login(),




  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = 'China';
  List countries = List();
  final String url =
      "https://coronavirus-monitor.p.rapidapi.com/coronavirus/affected.php";

  Future<String> getCountries() async {

    var res = await http
        .get(Uri.encodeFull(url), headers: {'x-rapidapi-host': 'coronavirus-monitor.p.rapidapi.com', 'x-rapidapi-key': '5a6d0f2dd4msh8f8a3f2ef05b212p10f6eejsn044cd4de01d8 '});
    var resBody = json.decode(res.body)['affected_countries'];

    setState(() {
      countries = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Corona Alert"),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: countries.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.toString()),
                    value: item.toString(),
                  );
                }).toList(),
              ),
              InkWell(
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(12.0),
                    child: Text('Start', style: TextStyle(fontSize: 25.0), textAlign: TextAlign.center,),
                  ),
                  highlightColor: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20/2),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StatisticsPage(country: dropdownValue,)
                        )
                    );
                  }
              )
            ],
          ),
        ));
  }
}
