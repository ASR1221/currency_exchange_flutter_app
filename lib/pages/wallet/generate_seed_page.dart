import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './wallet_page.dart';
import '../../widgets/background_gradient_wrapper.dart';
import '../../widgets/small_top_bar.dart';
import '../../constants/colors.dart' as colors;

class GenerateSeedPage extends StatefulWidget {
  const GenerateSeedPage({super.key});

  @override
  State<GenerateSeedPage> createState() => _GenerateSeedPageState();
}

class _GenerateSeedPageState extends State<GenerateSeedPage> {

  String seedPhrase = 'word aafas askdm asdasa asd asdasd asdsadk kjhfd';

  void changePage (int selectedPageIndex) {
    Navigator.pop(context);
  }

  Future<void> _coppyToClipboard(BuildContext context, String payload) async {
    Clipboard.setData(ClipboardData(text: payload));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Seed phrase copied'),),
    );
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

                const Text("Seed Phrase", textAlign: TextAlign.center, style: TextStyle(fontSize: 32),),

                const SizedBox(height: 40,),

                const Text("Make sure ti store the phrase in a very secure place.", style: TextStyle(fontSize: 18),),
          
                const SizedBox(height: 20,),
          
                const Text("You will be asked to write this seed phrase when you enter your wallet again.", style: TextStyle(fontSize: 18),),
          
                const SizedBox(height: 20,),
          
                const Text("Your seed phrase:", style: TextStyle(fontSize: 18),),

                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(seedPhrase, style: const TextStyle(fontSize: 20),),
                ),

                const SizedBox(height: 70,),

                GestureDetector(
                  onTap: () {
                    _coppyToClipboard(context, seedPhrase);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: colors.bottomNavGradient,
                    ),
                    child: const Text("Copy To Clipboard", style: TextStyle(color: colors.lightThemeTextColor, fontSize: 22),),
                  ),
                ),

                const SizedBox(height: 10,),

                GestureDetector(
                  onTap: () {
                    // TODO: Store public and private keys in shared pref
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WalletPage()));
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: colors.longButtonGradient,
                    ),
                    child: const Text("Create Wallet", style: TextStyle(color: colors.lightThemeTextColor, fontSize: 22),),
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
