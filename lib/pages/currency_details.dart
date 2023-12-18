import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_controller.dart';
import '../constants/colors.dart' as colors;
import '../widgets/chart.dart';
import '../widgets/small_top_bar.dart';
import '../widgets/background_gradient_wrapper.dart';
import '../extensions/custom_theme_extension.dart';
import '../models/crypto_model.dart';

class CurrencyDetailsPage extends StatefulWidget {
  CurrencyDetailsPage({super.key, required this.assetId, required this.baseCurrency});

  String assetId;
  String baseCurrency;

  @override
  State<CurrencyDetailsPage> createState() => _CurrencyDetailsPageState();
}

class _CurrencyDetailsPageState extends State<CurrencyDetailsPage> {

  String amountType = "hour";
  dynamic data = [];
  bool isLoading = true;

  List comparisonList = [];

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_){
      _repeatedAsyncMethod();
      Future.delayed(const Duration(seconds: 3), () {
        _onlyOnceAsyncMethod();
      });
    });

  }

  @override
  didUpdateWidget(CurrencyDetailsPage oldWidget) {
    print("hi");
    WidgetsBinding.instance.addPostFrameCallback((_){
      _repeatedAsyncMethod();
    });
    super.didUpdateWidget(oldWidget);
  }

  _repeatedAsyncMethod() async {
    CryptoModel cryptoModelObj = CryptoModel();
    dynamic x = await cryptoModelObj.historicalData(from: widget.assetId, to: widget.baseCurrency, timeAmount: amountType);

    setState(() {
      data = x;
      isLoading = false;
    });
  }

  _onlyOnceAsyncMethod() async {
    CryptoModel cryptoModelObj = CryptoModel();
    List<String> cryptoList = ["BTC", "ETH", "DOGE"];
    cryptoList.remove(widget.baseCurrency);
    dynamic x = await cryptoModelObj.getCurrenciesBased(baseFiat: widget.baseCurrency, cryptoList: cryptoList);

    if (x != null) {
      setState(() {
        comparisonList = x;
        isLoading = false;
      });
    }
  }

  void changePage (int selectedPageIndex) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderController>(
      builder: (context, provider, child) => Scaffold(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: isLoading ?
                const SizedBox(
                  height: 260,
                  width: double.infinity,
                  child: Center(child: Text("Loading"),),
                ) : CustomChart(data: data,),
              ),
              const SizedBox(height: 3,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TimeAmountButton(timeText: "hour", onTap: provider.setTimeAmount, selected: provider.timeAmount),
                    TimeAmountButton(timeText: "day", onTap: provider.setTimeAmount, selected: provider.timeAmount),
                    TimeAmountButton(timeText: "week", onTap: provider.setTimeAmount, selected: provider.timeAmount),
                    TimeAmountButton(timeText: "month", onTap: provider.setTimeAmount, selected: provider.timeAmount),
                    TimeAmountButton(timeText: "year", onTap: provider.setTimeAmount, selected: provider.timeAmount),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
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
                            Image.asset("images/crypto/${widget.assetId.toLowerCase()}.png", width: 30, height: 30,),
                            const SizedBox(width: 10,),
                            Text(widget.assetId, style: const TextStyle(fontSize: 28, color: colors.lightThemeTextColor),),
                          ],
                        ),
                      ),
                      
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Comparison", style: TextStyle(fontSize: 22, color: colors.lightThemeTextColor),),
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: comparisonList.map((e) => ComparisonListItem(assetId: e['asset_id'], rate: e['rate'])).toList(),
                      ),

                      Consumer<ProviderController>(
                        builder: (context, provider, child) => GestureDetector(
                          onTap: () {
                            if (provider.starredCurrencies.contains(widget.assetId)) {
                              provider.removeStarredCurrency(widget.assetId);
                            } else {
                              provider.addStarredCurrency(widget.assetId);
                            }
                          },
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Icon(provider.starredCurrencies.contains(widget.assetId) ? Icons.star_outlined : Icons.star_border_rounded, size: 28, color: colors.lightThemeTextColor,),
                                const SizedBox(width: 5,),
                                Text(
                                  provider.starredCurrencies.contains(widget.assetId) ? "Remove From Starred" : "Star Currency",
                                  style: const TextStyle(fontSize: 22, color: colors.lightThemeTextColor),
                                ),
                              ],),
                            ),
                          )
                        ),
                      ),
                    ],),
                  ),
                ),
              ),
            ],)
          ),
        ),
      )
    );
  }
}

class TimeAmountButton extends StatelessWidget {
  TimeAmountButton({
    super.key,
    required this.timeText,
    required this.selected,
    required this.onTap,
  });

  String timeText;
  String selected;
  void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(timeText);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: selected == timeText ? Theme.of(context).extension<CustomThemeExtension>()?.borderColor ?? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).extension<CustomThemeExtension>()?.borderColor ?? Colors.black),
        ),
        child: Text(timeText),
      ),
    );
  }
}

class ComparisonListItem extends StatelessWidget {
  ComparisonListItem({
    super.key,
    required this.assetId,
    required this.rate,
  });

  String assetId;
  double rate;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderController>(
      builder: (context, provider, child) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailsPage(assetId: assetId, baseCurrency: provider.baseCurrency,)));
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
                width: 120,
                child: Row(
                  children: [
                    Image.asset("images/crypto/${assetId.toLowerCase()}.png", width: 25, height: 25,),
                    const SizedBox(width: 15,),
                    Text(assetId, style: const TextStyle(fontSize: 18, color: colors.lightThemeTextColor),),
                  ],
                ),
              ),
              Text(rate.toStringAsFixed(6), style: const TextStyle(fontSize: 18, color: colors.lightThemeTextColor),),
            ],
          ),
        ),
      )
    );
  }
}
