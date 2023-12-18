import 'package:flutter/material.dart';

import '../models/crypto_model.dart';
import "../widgets/fav_card.dart";

class StarredPage extends StatefulWidget {
  StarredPage({super.key, required this.baseCurrency, required this.starredCurrencies});

  String baseCurrency;
  List<String> starredCurrencies;

  @override
  State<StarredPage> createState() => _StarredPageState();
}

class _StarredPageState extends State<StarredPage> with AutomaticKeepAliveClientMixin<StarredPage> {

  @override
  bool get wantKeepAlive => true;

  bool isLoading = true;
  late List starredItems;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

  }

  _asyncMethod() async {
    CryptoModel cryptoModelObj = CryptoModel();

    List results =
      await Future.wait(widget.starredCurrencies.map(
        (e) => cryptoModelObj.historicalData(from: e, to: widget.baseCurrency, timeAmount: 'hour')
        ));
    
    setState(() {
      starredItems = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 22),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: widget.starredCurrencies == null ? const Center(child: Text("No starred Items"),) :
          isLoading ? const Center(child: Text("Loading"),) :
            ListView.builder(
              itemCount: starredItems.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column(
                    children: [
                      const SizedBox(height: 10,),
                      FavCard(currency: widget.starredCurrencies[index], data: starredItems[index], baseCurrency: widget.baseCurrency,),
                    ],
                  );
                }
                return FavCard(currency: widget.starredCurrencies[index], data: starredItems[index], baseCurrency: widget.baseCurrency,);
              }
            ),
      ),
    );
  }
}