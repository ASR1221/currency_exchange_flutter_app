import "dart:convert";

import "package:http/http.dart" as http;
import '../constants/news.dart' as news;

class NewsModel {

  static final _url = news.url;

  Future<dynamic> getNews() async {

    http.Response response = await http.get(Uri.parse(_url), headers: { 'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      return null;
    }
    print(response.body);

    Map<String, dynamic> data = await jsonDecode(response.body);

    print("hi3");

    final finalData = data['articles']['results'].map((x) => {
      'date': x['date'],
      'image': x['image'],
      'url': x['url'],
      'title': x['title'],
      'body': x['body'],
    }).toList();

    return finalData;
  }

}
