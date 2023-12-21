import 'package:flutter/material.dart';

import './send_transaction_page.dart';
import './receive_transaction.dart';
import '../../widgets/background_gradient_wrapper.dart';
import '../../widgets/small_top_bar.dart';
import '../../constants/colors.dart' as colors;

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  String walletBalance = "20";

  void changePage (int selectedPageIndex) {
    Navigator.pop(context);
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

                Text(walletBalance, textAlign: TextAlign.center, style: const TextStyle(fontSize: 34),),

                const SizedBox(height: 120,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SendTransactionPage()));
                          },
                          child: Container(
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
                        ),
                        const SizedBox(height: 8,),
                        const Text("Send"),
                      ],
                    ),

                    const SizedBox(width: 50,),

                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiveTransactionPage()));
                          },
                          child: Container(
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
                        ),
                        const SizedBox(height: 8,),
                        const Text("Receive"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
