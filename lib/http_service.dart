import 'CountryStatistics.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class HttpService {
  final String postsURL =
      "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php";

  Future<List<CountryStatistics>> getCountries() async {
    var headers = {
      'x-rapidapi-host': 'coronavirus-monitor.p.rapidapi.com',
      'x-rapidapi-key': '5a6d0f2dd4msh8f8a3f2ef05b212p10f6eejsn044cd4de01d8 ',
    };

    Response res = await get(postsURL, headers: headers);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['countries_stat'];

      List<CountryStatistics> countries = body
          .map(
            (dynamic item) => CountryStatistics.fromJson(item),
          )
          .toList();

      return countries;
    } else {
      throw "Can't get posts.";
    }
  }
}
