import 'package:flutter/material.dart';

import '../../pages/wallet/import_wallet_page.dart';
import '../pages/wallet/create_wallet_page.dart';
import '../constants/colors.dart' as colors;
import '../extensions/custom_theme_extension.dart';

class WalletCreate extends StatelessWidget {
  const WalletCreate({super.key});

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
          const SizedBox(
            width: 150,
            child: Text("Get Into The Crypt World and Get Your Own Wallet", style: TextStyle(color: colors.darkThemeTextColor, fontSize: 22),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateWalletPage()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff73ACE1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("Create Wallet", style: TextStyle(fontSize: 16,),),
                ),
              ),
              const SizedBox(height: 25,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ImportWalletPage()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).extension<CustomThemeExtension>()?.borderColor ?? colors.darkThemeBorderColor),
                  ),
                  child: const Text("Import Wallet", style: TextStyle(fontSize: 16,),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}