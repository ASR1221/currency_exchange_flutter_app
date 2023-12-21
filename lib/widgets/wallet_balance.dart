import 'package:flutter/material.dart';

import '../constants/colors.dart' as colors;
import '../extensions/custom_theme_extension.dart';

class WalletBalance extends StatelessWidget {
  WalletBalance({super.key});

  // TODO: get balance from infura
  final String walletBalanceTx = "";

  // TODO: add loading state
  bool isLoading = true;

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
                isLoading ? const Text("Loading") : Text(walletBalanceTx, style: const TextStyle(fontSize: 24, color: colors.darkThemeTextColor,),),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {}, // TODO: navigate to wallet page
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