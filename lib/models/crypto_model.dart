import "dart:convert";

import "package:http/http.dart" as http;

import '../constants/currencies.dart';

class CryptoModel {

  static const _baseURL = "https://rest.coinapi.io/v1/APIKEY-3264E81B-B4F9-45A3-A41E-92ADF08B9F3E";

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
    String endDate = DateTime.now().toIso8601String();
    String startDate = '';
    String periodId = '';

    switch (timeAmount) {
      case 'hour':
        startDate = DateTime.now().subtract(const Duration(hours: 1)).toIso8601String();
        periodId = '3MIN';
        break;

      case 'day':
        startDate = DateTime.now().subtract(const Duration(days: 1)).toIso8601String();
        periodId = '2HRS';
        break;

      case 'week':
        startDate = DateTime.now().subtract(const Duration(days: 7)).toIso8601String();
        periodId = '12HRS';
        break;

      case 'month':
        startDate = DateTime.now().subtract(const Duration(days: 30)).toIso8601String();
        periodId = '2DAY';
        break;

      case 'year':
        startDate = DateTime.now().subtract(const Duration(days: 365)).toIso8601String();
        periodId = '10DAY';
        break;

      default:
        startDate = DateTime.now().subtract(const Duration(hours: 1)).toIso8601String();
        periodId = '3MIN';
        break;
    }

    http.Response response = await http.get(Uri.parse("$_baseURL/exchangerate/$from/$to/history?period_id=$periodId&time_start=$startDate&time_end=$endDate"));

    if (response.statusCode != 200) {
      return null;
    }

    List<Map<String, dynamic>> data = await jsonDecode(response.body);

    switch (timeAmount) {
      case 'hour':
        return data.map((e) => {
          'date': DateTime.parse(e['time_open']).minute + 1,
          'rate': e['rate_open'],
        });

      case 'day':
        return data.map((e) => {
          'date': DateTime.parse(e['time_open']).hour + 1,
          'rate': e['rate_open'],
        });

      case 'week':
        return data.map((e) => {
          'date': DateTime.parse(e['time_open']).weekday,
          'rate': e['rate_open'],
        });

      case 'month':
        return data.map((e) => {
          'date': DateTime.parse(e['time_open']).day,
          'rate': e['rate_open'],
        });

      case 'year':
        return data.map((e) => {
          'date': DateTime.parse(e['time_open']).month,
          'rate': e['rate_open'],
        });

      default:
        return data.map((e) => {
          'date': DateTime.parse(e['time_open']).minute + 1,
          'rate': e['rate_open'],
        });
    }
  }

}
