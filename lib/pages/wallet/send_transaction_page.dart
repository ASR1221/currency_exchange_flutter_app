import 'package:flutter/material.dart';

import '../../widgets/background_gradient_wrapper.dart';
import '../../widgets/small_top_bar.dart';
import '../../constants/colors.dart' as colors;

class SendTransactionPage extends StatefulWidget {
  const SendTransactionPage({super.key});

  @override
  State<SendTransactionPage> createState() => _SendTransactionPageState();
}

class _SendTransactionPageState extends State<SendTransactionPage> {

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

                const Text("Send Transaction", textAlign: TextAlign.center, style: TextStyle(fontSize: 32),),

                const SizedBox(height: 60,),

                const Text("Receiver Address", style: TextStyle(fontSize: 18),),

                TextField(),

                const SizedBox(height: 40,),

                const Text("Amount", style: TextStyle(fontSize: 18),),

                TextField(),

                const SizedBox(height: 120,),

                GestureDetector(
                  onTap: () {
                    // TODO: confirm transaction
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: colors.longButtonGradient,
                    ),
                    child: const Text("Confirm Transaction", style: TextStyle(color: colors.lightThemeTextColor, fontSize: 22),),
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
