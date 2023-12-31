import 'package:flutter/material.dart';

import '../models/crypto_model.dart';
import "../widgets/background_gradient_wrapper.dart";
import "../widgets/list_item.dart";

class CurrenciesPage extends StatefulWidget {
  CurrenciesPage({super.key, required this.baseCurrency});

  String baseCurrency;

  @override
  State<CurrenciesPage> createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {

  final TextEditingController _controller = TextEditingController();
  String searchText = "";

  bool isLoading = true;
  late List<Map<String, dynamic>> currencies;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

  }

  _asyncMethod() async {
    CryptoModel cryptoModelObj = CryptoModel();
    List<Map<String, dynamic>> x = await cryptoModelObj.getCurrenciesBased(baseFiat: widget.baseCurrency);
    if (x != null) {
      x.sort((a, b) => b['rate'].compareTo(a['rate']));
      setState(() {
        currencies = x;
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundGradientWrapper(
      childApp: Padding(
        padding: const EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 35),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: isLoading ? const Center(child: Text("Loading"),) : ListView.builder(
            itemCount: currencies.length,
            itemBuilder: (BuildContext context, int index) =>
              ListItem(assetId: currencies[index]['asset_id'], rate: currencies[index]['rate'], baseCurrency: widget.baseCurrency,),
          ),
        ),
      ),
    );
  }
}