import 'package:flutter/material.dart';

import '../pages/currency_details.dart';
import "./chart.dart";
import '../extensions/custom_theme_extension.dart';

class FavCard extends StatefulWidget {
  const FavCard({super.key});

  @override
  State<FavCard> createState() => _FavCardState();
}

class _FavCardState extends State<FavCard> {
  @override
  Widget build(BuildContext context) {

    final customTheme = Theme.of(context).extension<CustomThemeExtension>();

    return Container(
      width: double.infinity,
      height: 380,
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 0),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: customTheme?.borderColor ?? Colors.black),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("USD", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                SizedBox(
                  width: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("10.300", style: TextStyle(fontSize: 18),),
                      Text("+9.15%", style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          CustomChart(),

          Divider(
            height: 7,
            color: customTheme?.borderColor ?? Colors.black,
          ),

          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailsPage()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                color: Colors.transparent,
                child: const Center(child: Text("See Details",)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
