import 'package:final_project/widgets/base_dropdown.dart';
import 'package:final_project/widgets/number_button.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart' as colors;
import '../widgets/background_gradient_wrapper.dart';
import '../widgets/small_top_bar.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {

  String fromNumber = "0";
  String toNumber = "0";

  String fromBase = "USD";
  String toBase = "BTC";

  void handleNumberTap(String num) {
    setState(() {
      if (fromNumber == "0" && num == "0") {
        return;
      } else if (fromNumber.startsWith("0") && num != "0") {
        fromNumber = fromNumber.replaceFirst("0", "");
      }
      fromNumber = fromNumber + num;
    });
  }

  void handleDeleteTap() {
    setState(() {
      if (fromNumber.length == 1) {
        fromNumber = "0";
      } else {
        fromNumber = fromNumber.substring(0, fromNumber.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    void changePage(int x) {
      Navigator.pop(context);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SmallTopBar(title: "Converter", changePage: changePage,)
      ),
      body: BackGroundGradientWrapper(
        childApp: Padding(
        padding: const EdgeInsets.only(top: 130,),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                const Text("From: ", style: TextStyle(fontSize: 18),),
                const SizedBox(width: 20,),
                BaseDropdown(isMainBase: false, selectedValue: fromBase,),
              ],),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                const Text("To: ", style: TextStyle(fontSize: 18),),
                const SizedBox(width: 45,),
                BaseDropdown(isMainBase: false, selectedValue: toBase,),
              ],),
            ),
            const SizedBox(height: 40,),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: colors.topNavGradient,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17),),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 25),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(fromNumber, style: const TextStyle(fontSize: 25, color: colors.gradientBorderColor),),
                        const Icon(Icons.arrow_right_alt_rounded, color: colors.gradientBorderColor, size: 40,),
                        Text(toNumber, style: const TextStyle(fontSize: 25, color: colors.gradientBorderColor),),
                      ],
                    ),
                    const Divider(
                      height: 1,
                      color: colors.gradientBorderColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialNumberButton(btnNumber: "1", onTapHandler: () {handleNumberTap("1");}),
                        DialNumberButton(btnNumber: "2", onTapHandler: () {handleNumberTap("2");}),
                        DialNumberButton(btnNumber: "3", onTapHandler: () {handleNumberTap("3");},),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialNumberButton(btnNumber: "4", onTapHandler: () {handleNumberTap("4");}),
                        DialNumberButton(btnNumber: "5", onTapHandler: () {handleNumberTap("5");}),
                        DialNumberButton(btnNumber: "6", onTapHandler: () {handleNumberTap("6");}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialNumberButton(btnNumber: "7", onTapHandler: () {handleNumberTap("7");}),
                        DialNumberButton(btnNumber: "8", onTapHandler: () {handleNumberTap("8");}),
                        DialNumberButton(btnNumber: "9", onTapHandler: () {handleNumberTap("9");}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialNumberButton(btnNumber: ".", onTapHandler: () {handleNumberTap(".");}),
                        DialNumberButton(btnNumber: "0", onTapHandler: () {handleNumberTap("0");}),
                        DialNumberButton(btnNumber: "", onTapHandler: handleDeleteTap),
                      ],
                    ),
                  ]),
                ),
              ),
            )
          ],)
        ),
          ),
      ));
  }
}