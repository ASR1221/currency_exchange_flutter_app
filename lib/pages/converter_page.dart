import 'package:flutter/material.dart';

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

    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 22),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Center(child: Text("Not implemented yet"),)
      ),
    );
  }
}