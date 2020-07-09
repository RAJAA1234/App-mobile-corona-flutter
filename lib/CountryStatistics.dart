import 'package:flutter/foundation.dart';

class CountryStatistics {
  final String countryName;
  final String cases;
  final String deaths;
  final String region;
  final String totalRecovered;
  final String newDeaths;
  final String newCases;
  final String seriousCritical;

  CountryStatistics({
    @required this.countryName,
    @required this.cases,
    @required this.deaths,
    @required this.region,
    @required this.totalRecovered,
    @required this.newDeaths,
    @required this.newCases,
    @required this.seriousCritical,
  });

  factory CountryStatistics.fromJson(Map<String, dynamic> json) {
    return CountryStatistics(
      countryName: json['country_name'] as String,
      cases: json['cases'] as String,
      deaths: json['deaths'] as String,
      region: json['region'] as String,
      totalRecovered: json['total_recovered'] as String,
      newDeaths: json['new_deaths'] as String,
      newCases: json['new_cases'] as String,
      seriousCritical: json['serious_critical'] as String
    );
  }
}