import 'package:flutter/material.dart';

import '../widgets/small_top_bar.dart';
import '../widgets/background_gradient_wrapper.dart';
import '../constants/colors.dart' as colors;

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
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SmallTopBar(changePage: changePage,),
      ),
      body: BackGroundGradientWrapper(
        childApp: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                // child: Image.network(""),
              ),

              SizedBox(height: 20,),

              Text("Title", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),),

              SizedBox(height: 15,),

              Text("This is the body of the new where all the news are going to be displayed. It is goin to look amaizing.\n\nSo what is the latest new so we can tell you every thing.", style: TextStyle(fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }
}
