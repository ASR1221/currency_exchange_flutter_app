import 'package:flutter/material.dart';
import 'package:final_project/widgets/small_top_bar.dart';
import 'package:final_project/widgets/background_gradient_wrapper.dart';

class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({super.key});

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
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SmallTopBar(changePage: changePage,),
      ),
      body: BackGroundGradientWrapper(
        childApp: Center(child: Text("Not implemented yet"),),
      ),
    );
  }
}
