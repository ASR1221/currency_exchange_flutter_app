import 'package:flutter/material.dart';

import '../pages/currency_details.dart';
import "./chart.dart";
import '../extensions/custom_theme_extension.dart';

class FavCard extends StatefulWidget {
  FavCard({super.key, required this.currency, required this.data, required this.baseCurrency});

  String baseCurrency;
  String currency;
  dynamic data;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.currency, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
          ),
          const SizedBox(
            height: 10,
          ),

          CustomChart(data: widget.data,),

          Divider(
            height: 7,
            color: customTheme?.borderColor ?? Colors.black,
          ),

          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  CurrencyDetailsPage(assetId: widget.currency, baseCurrency: widget.baseCurrency,)));
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
