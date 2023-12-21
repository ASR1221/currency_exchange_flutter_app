import 'package:flutter/material.dart';

import '../widgets/wallet_balance.dart';
import '../widgets/wallet_create.dart';
import '../models/crypto_model.dart';
import "../widgets/fav_card.dart";

class StarredPage extends StatefulWidget {
  StarredPage({super.key, required this.baseCurrency, required this.starredCurrencies});

  String baseCurrency;
  List<String> starredCurrencies;

  @override
  State<StarredPage> createState() => _StarredPageState();
}

class _StarredPageState extends State<StarredPage> {

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

  Column walletSection({bool isLoading = false, bool isNull = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 10,),
      WalletBalance(), // TODO: make a condition to show WalletCreate or WalletBalance
      const SizedBox(height: 30,),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text("Starred Currencies", style: TextStyle(fontSize: 22),),
      ),
      SizedBox(height: isLoading || isNull ? 50 : 20,),
      if (isLoading || isNull) Center(
        child: Text(isNull ? "No Starred Currencies" : "Loading"),
      )
    ],);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 22),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: widget.starredCurrencies == null ? walletSection(isNull: true) :
          isLoading ? walletSection(isLoading: true):
            ListView.builder(
              itemCount: widget.starredCurrencies.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column(
                    children: [
                      walletSection(),
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