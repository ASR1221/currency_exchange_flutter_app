import 'package:flutter/material.dart';

import '../pages/currency_details.dart';
import '../extensions/custom_theme_extension.dart';
import "../constants/colors.dart" as colors;

class ListItem extends StatefulWidget {
  ListItem({super.key, required this.assetId, required this.rate, required this.baseCurrency});

  String baseCurrency;
  String assetId;
  double rate;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailsPage(assetId: widget.assetId, baseCurrency: widget.baseCurrency,)));
      },
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).extension<CustomThemeExtension>()?.borderColor ?? Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    color: Colors.transparent,
                    child: Image.asset("images/crypto/${widget.assetId.toLowerCase()}.png"),
                  ),
                  const SizedBox(width: 20,),
                  Text(widget.assetId, style: const TextStyle(fontSize: 18),),
                ],
              ),
            ),
            Text(widget.rate.toStringAsFixed(6), style: const TextStyle(fontSize: 18),),
          ],
        ),
      ),
    );
  }
}