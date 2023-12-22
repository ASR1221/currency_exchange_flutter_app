import "dart:convert";

import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

import '../constants/currencies.dart';

class CryptoModel {

  static const _baseURL = "https://rest.coinapi.io/v1/APIKEY-7C5C387C-F807-4AB5-BCC3-C5078CB61BAE";

  Future<dynamic> getCurrenciesBased({required String baseFiat, List<String> cryptoList = allCryptos}) async {

    http.Response response = await http.get(Uri.parse("$_baseURL/exchangerate/$baseFiat"));

    if (response.statusCode != 200) {
      return null;
    }

    Map<String, dynamic> data = await jsonDecode(response.body);

    List<Map<String, dynamic>> currencies = [];

    for (var asset in data['rates']) {
      if (cryptoList.contains(asset['asset_id_quote'])) {
        currencies.add({
          'asset_id': asset['asset_id_quote'],
          'rate': 1 / asset['rate'],
        });
      }
    }

    return currencies;
  }

  Future<dynamic> convertCurrencies({required String from, required String to, required double amount}) async {
    http.Response response = await http.get(Uri.parse("$_baseURL/exchangerate/$from/$to"));

    if (response.statusCode != 200) {
      return null;
    }

    Map<String, dynamic> data = await jsonDecode(response.body);

    return data['rate'] * amount;
  }

  Future<dynamic> historicalData({required String from, required String to, required String timeAmount}) async {
    String endDate = DateTime.now().toUtc().toIso8601String();
    String startDate = '';
    String periodId = '';

    switch (timeAmount) {
      case 'hour':
        startDate = DateTime.now().subtract(const Duration(hours: 1)).toUtc().toIso8601String();
        periodId = '3MIN';
        break;

      case 'day':
        startDate = DateTime.now().subtract(const Duration(days: 1)).toUtc().toIso8601String();
        periodId = '2HRS';
        break;

      case 'week':
        startDate = DateTime.now().subtract(const Duration(days: 7)).toUtc().toIso8601String();
        periodId = '12HRS';
        break;

      case 'month':
        startDate = DateTime.now().subtract(const Duration(days: 30)).toUtc().toIso8601String();
        periodId = '2DAY';
        break;

      case 'year':
        startDate = DateTime.now().subtract(const Duration(days: 365)).toUtc().toIso8601String();
        periodId = '10DAY';
        break;

      default:
        startDate = DateTime.now().subtract(const Duration(hours: 1)).toUtc().toIso8601String();
        periodId = '3MIN';
        break;
    }

    endDate = endDate.substring(0, endDate.length - 4);
    startDate = startDate.substring(0, startDate.length - 4);

    http.Response response = await http.get(Uri.parse("$_baseURL/exchangerate/$from/$to/history?period_id=$periodId&time_start=$startDate&time_end=$endDate"));

    if (response.statusCode != 200) {
      return null;
    }

    List data = await jsonDecode(response.body);

    switch (timeAmount) {
      case 'hour':
        return data.map((e) => {
          'date': DateFormat('hh:mm a').format(DateTime.parse(e['time_open'])),
          'rate': e['rate_open'],
        }).toList();

      case 'day':
        return data.map((e) => {
          'date': DateFormat('hh:mm a').format(DateTime.parse(e['time_open'])),
          'rate': e['rate_open'],
        }).toList();

      case 'week':
        return data.map((e) => {
          'date': DateFormat('EEE').format(DateTime.parse(e['time_open'])),
          'rate': e['rate_open'],
        }).toList();

      case 'month':
        return data.map((e) => {
          'date': DateFormat('d MMM').format(DateTime.parse(e['time_open'])),
          'rate': e['rate_open'],
        }).toList();

      case 'year':
        return data.map((e) => {
          'date': DateFormat('d MMM').format(DateTime.parse(e['time_open'])),
          'rate': e['rate_open'],
        }).toList();

      default:
        return data.map((e) => {
          'date': DateFormat('hh:mm a').format(DateTime.parse(e['time_open'])),
          'rate': e['rate_open'],
        }).toList();
    }
  }

}
