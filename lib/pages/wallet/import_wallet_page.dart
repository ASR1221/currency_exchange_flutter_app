import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './wallet_page.dart';
import '../../utils/wallet.dart';
import '../../widgets/background_gradient_wrapper.dart';
import '../../widgets/small_top_bar.dart';
import '../../constants/colors.dart' as colors;

class ImportWalletPage extends StatefulWidget {
  const ImportWalletPage({super.key});

  @override
  State<ImportWalletPage> createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {

  TextEditingController controller = TextEditingController();

  bool isError = false;

  void changePage (int selectedPageIndex) {
    Navigator.pop(context);
  }

  _asyncMethod() async {

    final prefs = await SharedPreferences.getInstance();

    WalletAddress service = WalletAddress();
    final mnemonic = controller.text;
    try {
      final privateKey = await service.getPrivateKey(mnemonic);
      final publicKey = service.getPublicKey(privateKey).hex;

      prefs.setString("privateKey", privateKey);
      prefs.setString("publicKey", publicKey);

      if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletPage()));
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SmallTopBar(changePage: changePage,),
      ),
      body: BackGroundGradientWrapper(
        childApp: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: ListView(
              children: [
                const SizedBox(height: 10,),

                const Text("Send Transaction", textAlign: TextAlign.center, style: TextStyle(fontSize: 32),),

                const SizedBox(height: 60,),

                const Text("Seed Phrase", style: TextStyle(fontSize: 18),),

                TextField(
                  controller: controller,
                  onChanged: (x) {
                    setState(() {
                      isError = true;
                    });
                  },
                ), // TODO: style textfield

                if (isError) const Text("Error: not a seed phrase", style: TextStyle(color: Colors.red),),

                const SizedBox(height: 140,),

                GestureDetector(
                  onTap: () {
                    // TODO: Import wallet
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: colors.longButtonGradient,
                    ),
                    child: const Text("Import Wallet", style: TextStyle(color: colors.lightThemeTextColor, fontSize: 22),),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
