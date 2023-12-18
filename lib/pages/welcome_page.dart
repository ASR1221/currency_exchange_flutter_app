import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../widgets/background_gradient_wrapper.dart';
import '../extensions/custom_theme_extension.dart';
import '../provider/provider_controller.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key, required this.provider});

  ProviderController provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundGradientWrapper(
        childApp: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 200,),
            Image.asset("images/logo.png", width: 120, height: 120,),
            const SizedBox(height: 5, width: double.infinity,),
            const Text("Currensee", style: TextStyle(fontSize: 34),),
            const SizedBox(height: 30,),
            const Text("All you need about Crypto Currencies", style: TextStyle(fontSize: 16),),
            const SizedBox(height: 70,),
            Consumer<ProviderController>(
              builder: (context, provider, child) => GestureDetector(
                onTap: () {
                  provider.endFirstEnter();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(provider: provider,)));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Theme.of(context).extension<CustomThemeExtension>()?.borderColor ?? Colors.black),
                  ),
                  child: const Text("Enter App", style: TextStyle(fontSize: 24),)
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}