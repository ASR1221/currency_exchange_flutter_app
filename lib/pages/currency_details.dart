import 'package:flutter/material.dart';

import '../constants/colors.dart' as colors;
import '../widgets/chart.dart';
import '../widgets/small_top_bar.dart';
import '../widgets/background_gradient_wrapper.dart';

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
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SmallTopBar(changePage: changePage,)
      ),
      body: BackGroundGradientWrapper(
        childApp: Padding(
          padding: const EdgeInsets.only(top: 130,),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: CustomChart(),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: colors.topNavGradient,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17),),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 22, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: colors.loadingPlaceholderGradient,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Text("USD", style: TextStyle(fontSize: 28, color: colors.lightThemeTextColor),),
                        ],
                      ),
                    ),
                    
                    const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text("Comparison", style: TextStyle(fontSize: 22, color: colors.lightThemeTextColor),),
                    ),


                    const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                      ComparisonListItem(),
                      ComparisonListItem(),
                      ComparisonListItem(),
                      ComparisonListItem(),
                    ],),

                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: colors.lightThemeTextColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(Icons.star_border_rounded, size: 28, color: colors.lightThemeTextColor,),
                            SizedBox(width: 5,),
                            Text("Star Currency", style: TextStyle(fontSize: 22, color: colors.lightThemeTextColor),),
                          ],),
                        ),
                      )
                    ),
                  ],),
                ),
              ),
            ),
          ],)
        ),
      ),
    );
  }
}

class ComparisonListItem extends StatelessWidget {
  const ComparisonListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailsPage()));
      },
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 25,
                    decoration: BoxDecoration(
                      gradient: colors.loadingPlaceholderGradient,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  Text("USD", style: TextStyle(fontSize: 18, color: colors.lightThemeTextColor),),
                ],
              ),
            ),
            Text("10.300", style: TextStyle(fontSize: 18, color: colors.lightThemeTextColor),),
          ],
        ),
      ),
    );
  }
}
