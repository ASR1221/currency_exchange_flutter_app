import 'package:flutter/material.dart';

import '../models/news_model.dart';
import "../widgets/news_card.dart";

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin<NewsPage> {

  late List news = [];
  bool isLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

  }

  _asyncMethod() async {
    NewsModel cryptoModelObj = NewsModel();

    final tempNews = await cryptoModelObj.getNews();

    setState(() {
      news = tempNews;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 22),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: isLoading ? const Center(child: Text("Loading"),) : ListView.builder(
          itemCount: news.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  const SizedBox(height: 30,),
                  NewsCard(news: news[index]),
                ],
              );
            } else {
              return NewsCard(news: news[index]);
            }
          }
        ),
      ),
    );
  }
}