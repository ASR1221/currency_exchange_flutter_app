import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generate_seed_page.dart';
import '../../widgets/background_gradient_wrapper.dart';
import '../../widgets/small_top_bar.dart';
import '../../constants/colors.dart' as colors;

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({super.key});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {

  void changePage (int selectedPageIndex) {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });
  }

  _asyncMethod() async {

    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString("publicKey") == null || prefs.getString("publicKey")!.isEmpty) {
      if (context.mounted) Navigator.pop(context);
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

                const Text("Create Wallet", textAlign: TextAlign.center, style: TextStyle(fontSize: 32),),

                const SizedBox(height: 50,),

                const Text("To create a wallet, your will get a seed phrase containing 12 words", style: TextStyle(fontSize: 18),),
          
                const SizedBox(height: 30,),
          
                const Text("A seed phrase is like a password to your wallet. If you lose it, your wallet might be compromised", style: TextStyle(fontSize: 18),),
          
                const SizedBox(height: 30,),
          
                const Text("CurrenSee will NOT store your seed phrase for you. You must store it in a safe an secure place where no one can see it.", style: TextStyle(fontSize: 18),),

                const SizedBox(height: 70,),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateSeedPage()));
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: colors.longButtonGradient,
                    ),
                    child: const Text("Generate Seed Phrase", style: TextStyle(color: colors.lightThemeTextColor, fontSize: 22),),
                  ),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
