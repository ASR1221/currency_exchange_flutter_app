import 'package:final_project/extensions/custom_theme_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../app.dart';
import '../../constants/colors.dart' as colors;

class IntroScreensPage extends StatefulWidget {
  const IntroScreensPage({Key? key}) : super(key: key);

  @override
  IntroScreensPageState createState() => IntroScreensPageState();
}

class IntroScreensPageState extends State<IntroScreensPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0);

    bool isLight = Theme.of(context).extension<CustomThemeExtension>()?.borderColor == colors.lightThemeBorderColor ? true : false;

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.symmetric(vertical: 5),
    );

    Container containerGradient() {
      Color color = isLight ? colors.mainLightBgColor : colors.mainDarkBgColor;

      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.15, 0.5, 0.85, 1],
            colors: [
              color,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              color
            ],
          )
        ),
      );
    }

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: isLight ? colors.mainLightBgColor : colors.mainDarkBgColor ,
      allowImplicitScrolling: true,
      autoScrollDuration: 4000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "CurrenSee",
          body: "Every thing you need for your crypto currencies journey",
          image: Image.asset("images/logo.png", width: 200, height: 200,),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Crypto Wallet",
          body: "Create a crypto wallet and start sending and receiving crypto currencies",
          image: Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("images/wallet-intro.png",), fit: BoxFit.cover),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Live Currencies Rates",
          body: "Watch a list of crypto currencies with their rate based on any currency you like",
          image: Container(
            width: 265,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(isLight ? "images/currency-light.jpg" : "images/currency-dark.jpg",), fit: BoxFit.cover),
            ),
            child: containerGradient(),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Historical Rates",
          body: "Rates for a currency from an hour, day, week, month or even a year displayed in a chart",
          image: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("images/chart.png"), fit: BoxFit.cover),
            ),
            // child: containerGradient(),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Convert Any Currency",
          body: "Convert any crypto currency to any real world currency easily",
          image: Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("images/convert-large.png",), fit: BoxFit.cover),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Crypto News",
          body: "Read crypto news from many different sources",
          image: Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("images/news-large.png",), fit: BoxFit.cover),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: const Icon(Icons.arrow_back, color: colors.mainPurpuleColor),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: colors.mainPurpuleColor, fontFamily: "Play")),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: colors.mainPurpuleColor, fontFamily: "Play")),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Theme.of(context).extension<CustomThemeExtension>()?.borderColor ?? Colors.black,
        activeColor: colors.mainPurpuleColor,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}