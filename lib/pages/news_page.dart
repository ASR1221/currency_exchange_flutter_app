import 'package:flutter/material.dart';

import "../widgets/news_card.dart";

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin<NewsPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 22),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const Column(
              children: [
                SizedBox(height: 30,),
                NewsCard(),
              ],
            );
            } else {
              return const NewsCard();
            }
          }
        ),
      ),
    );
  }
}