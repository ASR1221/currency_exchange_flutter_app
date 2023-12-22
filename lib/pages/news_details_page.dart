import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/small_top_bar.dart';
import '../widgets/background_gradient_wrapper.dart';
import '../constants/colors.dart' as colors;

class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({super.key, required this.news});

  final dynamic news;

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {

  void changePage (int selectedPageIndex) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SmallTopBar(changePage: changePage,),
      ),
      body: BackGroundGradientWrapper(
        childApp: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: colors.loadingPlaceholderGradient,
                ),
                child: widget.news['image'] == null ? null : Image.network(widget.news['image']!, fit: BoxFit.cover,),
              ),

              const SizedBox(height: 20,),

              Text(widget.news['title'] ?? "", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),),

              const SizedBox(height: 5,),

              Text(widget.news['date'] ?? "", style: const TextStyle(fontSize: 12),),

              const SizedBox(height: 15,),

              Text(widget.news['body'] ?? "", style: const TextStyle(fontSize: 16),),

              const SizedBox(height: 25,),

              GestureDetector(
                onTap: () => launchUrl(Uri.parse(widget.news['url'])),
                child: Text('source: ${widget.news["url"]}', style: TextStyle(color: Colors.red[200]),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
