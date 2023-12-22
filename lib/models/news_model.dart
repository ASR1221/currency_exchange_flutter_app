import "dart:convert";

import "package:http/http.dart" as http;

class NewsModel {

  static const _url = "https://www.newsapi.ai/api/v1/article/getArticles?conceptUri=http://en.wikipedia.org/wiki/Cryptocurrency&dataType=news&resultType=articles&articlesSortBy=date&lang=eng&apiKey=9f3fa104-1c4e-4670-8e26-a41b855213ec";

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
