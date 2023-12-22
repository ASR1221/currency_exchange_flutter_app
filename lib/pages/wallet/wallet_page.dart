import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';
import '../../utils/wallet.dart';
import './send_transaction_page.dart';
import './receive_transaction.dart';
import '../../widgets/background_gradient_wrapper.dart';
import '../../widgets/small_top_bar.dart';
import '../../constants/colors.dart' as colors;
import '../../utils/hexa_to_double.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  String walletBalance = "0";
  bool isLoading = true;

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
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    }

    final publicKey = prefs.getString("publicKey");

    WalletAddress service = WalletAddress();

    final balance = await service.getBalance(publicKey!);

    setState(() {
      walletBalance = hexStringToDouble(balance['result']).toString();
      isLoading = false;
    });
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

                const Text("Wallet Balance", textAlign: TextAlign.center, style: TextStyle(fontSize: 32),),

                const SizedBox(height: 20,),

                isLoading ? const Text("Loading", textAlign: TextAlign.center,) : Text(walletBalance, textAlign: TextAlign.center, style: const TextStyle(fontSize: 34),),

                const SizedBox(height: 120,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SendTransactionPage()));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: colors.longButtonGradient,
                            ),
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(-55 / 360),
                              child: Image.asset("images/arrow.png"),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          const Text("Send"),
                        ],
                      ),
                    ),

                    const SizedBox(width: 50,),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiveTransactionPage()));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: colors.longButtonGradient,
                            ),
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(90 / 360),
                              child: Image.asset("images/arrow.png"),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          const Text("Receive"),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40,),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: colors.longButtonGradient,
                          ),
                          child: Image.asset("images/home.png"),
                        ),
                        const SizedBox(height: 8,),
                        const Text("Home Page"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40,),

                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove("publicKey");
                      prefs.remove("privateKey");

                      if (context.mounted) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red,
                          ),
                          child: Image.asset("images/log-out.png"),
                        ),
                        const SizedBox(height: 8,),
                        const Text("Log Out"),
                      ],
                    ),
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
