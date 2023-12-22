import 'package:flutter/material.dart';

import '../pages/news_details_page.dart';
import '../extensions/custom_theme_extension.dart';
import "../constants/colors.dart" as colors;

class NewsCard extends StatefulWidget {
  const NewsCard({super.key, required this.news});

  final dynamic news;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  String trimText(String originalText,) {
  if (originalText.length <= 55) {
    return originalText;
  } else {
    return '${originalText.substring(0, 55)}...';
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsPage(news: widget.news!)));
      },
      child: Container(
        width: double.infinity,
        height: 230,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).extension<CustomThemeExtension>()?.borderColor ?? Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                gradient: colors.loadingPlaceholderGradient,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              ),
              child: widget.news['image'] == null ? null : Image.network(widget.news['image']!, fit: BoxFit.cover,),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Text(trimText(widget.news['title']!), style: const TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}