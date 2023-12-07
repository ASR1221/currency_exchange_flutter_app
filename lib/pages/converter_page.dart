import 'package:flutter/material.dart';

import '../widgets/background_gradient_wrapper.dart';
import '../widgets/small_top_bar.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> with AutomaticKeepAliveClientMixin<ConverterPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    void changePage(int x) {
      Navigator.pop(context);
    }

    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SmallTopBar(title: "Converter", changePage: changePage,)
      ),
      body: BackGroundGradientWrapper(
        childApp: Padding(
        padding: const EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 22),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Center(child: Text("Not implemented yet"),)
        ),
          ),
      ));
  }
}