import 'package:final_project/widgets/base_dropdown.dart';
import 'package:final_project/widgets/number_button.dart';
import 'package:flutter/material.dart';

import '../widgets/background_gradient_wrapper.dart';
import '../widgets/small_top_bar.dart';
import '../constants/colors.dart' as colors;

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
        padding: const EdgeInsets.only(top: 130,),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(children: [
            const Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text("From: ", style: TextStyle(fontSize: 18),),
                SizedBox(width: 20,),
                BaseDropdown(),
              ],),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text("To: ", style: TextStyle(fontSize: 18),),
                SizedBox(width: 45,),
                BaseDropdown(),
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 25),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("100", style: TextStyle(fontSize: 25, color: colors.gradientBorderColor),),
                        Icon(Icons.arrow_right_alt_rounded, color: colors.gradientBorderColor, size: 40,),
                        Text("160", style: TextStyle(fontSize: 25, color: colors.gradientBorderColor),),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: colors.gradientBorderColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialNumberButton(btnNumber: "1"),
                        DialNumberButton(btnNumber: "2"),
                        DialNumberButton(btnNumber: "3"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialNumberButton(btnNumber: "4"),
                        DialNumberButton(btnNumber: "5"),
                        DialNumberButton(btnNumber: "6"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialNumberButton(btnNumber: "7"),
                        DialNumberButton(btnNumber: "8"),
                        DialNumberButton(btnNumber: "9"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialNumberButton(btnNumber: "."),
                        DialNumberButton(btnNumber: "0"),
                        DialNumberButton(btnNumber: ""), // TODO
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