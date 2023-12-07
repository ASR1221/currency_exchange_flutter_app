import 'package:flutter/material.dart';
import 'package:final_project/widgets/small_top_bar.dart';
import 'package:final_project/widgets/background_gradient_wrapper.dart';

class CurrencyDetailsPage extends StatefulWidget {
  const CurrencyDetailsPage({super.key});

  @override
  State<CurrencyDetailsPage> createState() => _CurrencyDetailsPageState();
}

class _CurrencyDetailsPageState extends State<CurrencyDetailsPage> {

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
