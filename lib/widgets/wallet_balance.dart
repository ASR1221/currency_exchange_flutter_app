import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart' as colors;
import '../pages/wallet/wallet_page.dart';
import '../utils/wallet.dart';
import '../utils/hexa_to_double.dart';

class WalletBalance extends StatefulWidget {
  const WalletBalance({super.key});

  @override
  State<WalletBalance> createState() => _WalletBalanceState();
}

class _WalletBalanceState extends State<WalletBalance> {

  String walletBalance = '0';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

  }

  _asyncMethod() async {

    final prefs = await SharedPreferences.getInstance();

    final publicKey = prefs.getString("publicKey");

    WalletAddress service = WalletAddress();

    final balance = await service.getBalance(publicKey!);

    print(balance);
    if (!mounted) return;
    setState(() {
      walletBalance = hexStringToDouble(balance['result']).toString();
      isLoading = false;
    });

    print(walletBalance);
    print(isLoading);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        gradient: colors.walletCardGradient,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colors.darkThemeBorderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 170,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Wallet Balance", style: TextStyle(fontSize: 22, color: colors.darkThemeTextColor,),),
                const SizedBox(height: 15,),
                isLoading ? const Text("Loading") : Text(walletBalance, style: const TextStyle(fontSize: 24, color: colors.darkThemeTextColor,),),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WalletPage()));
            }, // TODO: navigate to wallet page
            child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xff73ACE1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("images/wallet.png",),
            ),
          ),
        ],
      ),
    );
  }
}