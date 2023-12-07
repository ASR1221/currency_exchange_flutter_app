import 'package:flutter/material.dart';

import "../widgets/list_item.dart";
import "../widgets/background_gradient_wrapper.dart";

class CurrenciesPage extends StatefulWidget {
  const CurrenciesPage({super.key});

  @override
  State<CurrenciesPage> createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {

  @override
  Widget build(BuildContext context) {
    return BackGroundGradientWrapper(
      childApp: Padding(
        padding: const EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 55),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return const Column(
                children: [
                  // TODO: SeacrhBar implementation
                  SizedBox(height: 30,),
                  ListItem(),
                ],
              );
              } else {
                return const ListItem();
              }
            }
          ),
        ),
      ),
    );
  }
}