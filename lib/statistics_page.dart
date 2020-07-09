import 'CountryStatistics.dart';
import 'package:flutter/material.dart';
import 'my_card.dart';
import 'http_service.dart';

class StatisticsPage extends StatelessWidget {
  final HttpService httpService = HttpService();
  final String country;

  StatisticsPage({@required this.country});

  @override
  Widget build(BuildContext context) {
    httpService.getCountries();
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics of " + country),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: httpService.getCountries(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CountryStatistics>> snapshot) {
          if (snapshot.hasData) {
            List<CountryStatistics> stats = snapshot.data;
            CountryStatistics country = stats.where((item) => item.countryName.contains(this.country)).toList()[0];
            return GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                MyCard(iconCode: 59574, iconTitle: 'Total Cases', value: country.cases, color: Colors.yellow[700],),
                MyCard(iconCode: 57438, iconTitle: 'New Cases', value: country.newCases, color: Colors.yellow[700],),
                MyCard(iconCode: 57346, iconTitle: 'Total Deaths', value: country.deaths, color: Colors.red),
                MyCard(iconCode: 57347, iconTitle: 'New Deaths', value: country.newDeaths, color: Colors.red,),
                MyCard(iconCode: 58355, iconTitle: 'Total Recovered', value: country.totalRecovered, color: Colors.greenAccent,),
                MyCard(iconCode: 57696, iconTitle: 'Serious Critical', value: country.seriousCritical, color: Colors.pink[900],),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );

//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Statistics'),
//      ),
//      body: GridView.count(
//        crossAxisCount: 2,
//        children: <Widget>[
//          MyCard(iconCode: 57744, iconTitle: 'Clock'),
//          MyCard(iconCode: 57744, iconTitle: 'Clock'),
//          MyCard(iconCode: 57744, iconTitle: 'Clock'),
//          MyCard(iconCode: 57744, iconTitle: 'Clock'),
//        ],
//      ),
//    );
  }
}
