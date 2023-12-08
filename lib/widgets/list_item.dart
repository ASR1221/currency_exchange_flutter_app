import 'package:flutter/material.dart';

import '../pages/currency_details.dart';
import '../extensions/custom_theme_extension.dart';
import "../constants/colors.dart" as colors;

class ListItem extends StatefulWidget {
  const ListItem({super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailsPage()));
      },
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).extension<CustomThemeExtension>()?.borderColor ?? Colors.black),
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
                  Text("USD", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            SizedBox(
              width: 150,
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
    );
  }
}