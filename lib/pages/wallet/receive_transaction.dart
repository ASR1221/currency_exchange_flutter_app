import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';
import '../../widgets/background_gradient_wrapper.dart';
import '../../widgets/small_top_bar.dart';
import '../../constants/colors.dart' as colors;

class ReceiveTransactionPage extends StatefulWidget {
  const ReceiveTransactionPage({super.key});

  @override
  State<ReceiveTransactionPage> createState() => _ReceiveTransactionPageState();
}

class _ReceiveTransactionPageState extends State<ReceiveTransactionPage> {

  String publicKey = "";

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

    setState(() {
      publicKey = prefs.getString("publicKey") ?? "";
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

                const Text("Receive Transaction", textAlign: TextAlign.center, style: TextStyle(fontSize: 32),),

                const SizedBox(height: 60,),

                Text(publicKey, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20),),

                const SizedBox(height: 220,),

                GestureDetector(
                  onTap: () {
                    _coppyToClipboard(context, publicKey);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: colors.longButtonGradient,
                    ),
                    child: const Text("Copy To Clipboard", style: TextStyle(color: colors.lightThemeTextColor, fontSize: 22),),
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
