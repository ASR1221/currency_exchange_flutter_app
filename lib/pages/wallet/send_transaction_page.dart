import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import '../../app.dart';
import '../../utils/wallet.dart';
import '../../widgets/background_gradient_wrapper.dart';
import '../../widgets/small_top_bar.dart';
import '../../constants/colors.dart' as colors;

class SendTransactionPage extends StatefulWidget {
  const SendTransactionPage({super.key});

  @override
  State<SendTransactionPage> createState() => _SendTransactionPageState();
}

class _SendTransactionPageState extends State<SendTransactionPage> {

  TextEditingController receiverController = TextEditingController();
  TextEditingController amountController = TextEditingController();


  late SharedPreferences prefs;

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

    prefs = await SharedPreferences.getInstance();

    if (prefs.getString("publicKey") == null || prefs.getString("publicKey")!.isEmpty) {
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    }
  }

  Future<void> _coppyToClipboard(BuildContext context, String payload) async {
    Clipboard.setData(ClipboardData(text: payload));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Seed phrase copied'),),
    );
  }

  Future<void> sendTransaction() async {

    if (receiverController.text.isEmpty || amountController.text.isEmpty) {
      return;
    }

    final privateKey = prefs.getString("privateKey");

    WalletAddress service = WalletAddress();
    
    await service.sendTransaction(receiverController.text, amountController.text, privateKey ?? "");

    await _coppyToClipboard(context, "Transaction Completed");

    if (context.mounted) Navigator.pop(context);
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

                TextField(
                  controller: receiverController,
                ),

                const SizedBox(height: 40,),

                const Text("Amount", style: TextStyle(fontSize: 18),),

                TextField(
                  controller: amountController,
                ),

                const SizedBox(height: 120,),

                GestureDetector(
                  onTap: () {
                    sendTransaction();
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
