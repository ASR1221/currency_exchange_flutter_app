import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import 'package:provider/provider.dart';

import './pages/news_page.dart';
import './pages/welcome_page.dart';
import './pages/converter_page.dart';
import "./pages/currencies_page.dart";
import "./pages/starred_page.dart";
import './widgets/background_gradient_wrapper.dart';
import './widgets/small_top_bar.dart';

import "./constants/colors.dart" as colors;
import "./widgets/top_bar.dart";
import './extensions/custom_theme_extension.dart';
import './provider/provider_controller.dart';
import './widgets/bottom_navbar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData darkTheme(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: "Play",
              bodyColor: colors.darkThemeTextColor,
              displayColor: colors.darkThemeTextColor,
            ),
        appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            titleTextStyle: TextStyle(
              color: colors.darkThemeTextColor,
              fontFamily: "Play",
              fontSize: 28,
            )),
        extensions: const [
          CustomThemeExtension(
            bgGradient: colors.darkThemeBgGradient,
            borderColor: colors.darkThemeBorderColor,
            textColor: colors.darkThemeTextColor,
          ),
        ]);
  }

  ThemeData lightTheme(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: "Play",
              bodyColor: colors.lightThemeBorderColor,
              displayColor: colors.lightThemeBorderColor,
            ),
        appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            titleTextStyle: TextStyle(
              color: colors.lightThemeBorderColor,
              fontFamily: "Play",
              fontSize: 28,
            )),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                textStyle: MaterialStateTextStyle.resolveWith((states) =>
                    const TextStyle(color: colors.lightThemeBorderColor)))),
        extensions: const [
          CustomThemeExtension(
            bgGradient: colors.lightThemeBgGradient,
            borderColor: colors.lightThemeBorderColor,
            textColor: colors.lightThemeBorderColor,
          ),
        ]);
  }

  ThemeMode themeMode(ProviderController provider) {
    return provider.currentThemeId == 0
        ? ThemeMode.system
        : provider.currentThemeId == 1
            ? ThemeMode.light
            : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderController>(
      builder: (context, provider, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Final Project',
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        themeMode: themeMode(provider),
        home: provider.isFirstEnter ? WelcomePage(provider: provider) : MyHomePage(provider: provider,),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.provider});

  ProviderController provider;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _height = 90;
  bool _isOpen = false;

  void setHeight() {
    setState(() {
      if (_isOpen) {
        _isOpen = false;
        Future.delayed(const Duration(milliseconds: 300), () {
          _height = 90;
        });
      } else {
        _height = 390;
        _isOpen = true;
      }
    });
  }

  late int _selectedPageIndex;
  late PageController _pageController = PageController(initialPage: _selectedPageIndex);

  void changePage (int selectedPageIndex) {

    if (selectedPageIndex == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConverterPage()));
      return;
    }

    setState(() {
      _selectedPageIndex = selectedPageIndex;
      _pageController.jumpToPage(selectedPageIndex);
    });
  }

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_height),
        child: _selectedPageIndex == 2 ? SmallTopBar(title: "Converter", changePage: changePage,) : TopBar(
          pageTitle: _selectedPageIndex == 0 ? "Home" : _selectedPageIndex == 1 ? "Currencies" : _selectedPageIndex == 3 ? "News" : "",
          isOpen: _isOpen,
          setHeight: setHeight
        ),
      ),
      bottomNavigationBar: _selectedPageIndex == 2 ? null : BottomNavBar(selectedIndex: _selectedPageIndex, changePage: changePage,),
      body: BackGroundGradientWrapper(
        childApp: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (selectedPageIndex) {
            setState(() {
              _selectedPageIndex = selectedPageIndex;
            });
          },
          children: <Widget>[
            StarredPage(baseCurrency: widget.provider.baseCurrency, starredCurrencies: widget.provider.starredCurrencies,),
            CurrenciesPage(baseCurrency: widget.provider.baseCurrency,),
            const Placeholder(),
            const NewsPage(),
          ]
        ),
      ),
    );
  }
}
