import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/small_top_bar.dart';
import '../widgets/background_gradient_wrapper.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

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
                const SizedBox(height: 30,),

                Image.asset("images/logo.png", width: 140, height: 140,),

                const SizedBox(height: 15,),

                const Text("CurrenSee", textAlign: TextAlign.center, style: TextStyle(fontSize: 28),),
          
                const SizedBox(height: 100,),
          
                const Text("Created By Abdullah Salah", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
          
                const SizedBox(height: 25,),
          
                const Text("Contact Info", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),

                const SizedBox(height: 15,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => launchUrl(Uri.parse("https://www.linkedin.com/in/abdullah-salah-29209b235")),
                      child: Image.asset("images/linked.png", width: 50, height: 50,),
                    ),
                    
                    InkWell(
                      onTap: () => launchUrl(Uri.parse("mailto:asr12211@outlook.com")),
                      child: Image.asset("images/email.png", width: 55, height: 55,),
                    ),
          
                    InkWell(
                      onTap: () => launchUrl(Uri.parse("https://github.com/ASR1221?tab=repositories")),
                      child: Image.asset("images/github.png", width: 50, height: 50,),
                    ),
          
                    InkWell(
                      onTap: () => launchUrl(Uri.parse("https://t.me/asr_1221")),
                      child: Image.asset("images/telegram.png", width: 50, height: 50,),
                    ),
                  ],
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
