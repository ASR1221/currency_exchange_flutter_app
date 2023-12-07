import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "../constants/colors.dart" as colors;
import "base_dropdown.dart";
import "theme_selection.dart";

class TopBar extends StatefulWidget {
  const TopBar({
    super.key, 
    required this.pageTitle, 
    required this.isOpen, 
    required this.height, 
    required this.setHeight
  });

  final String pageTitle;
  final bool isOpen;
  final double height;  // may be deleted
  final Function() setHeight;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  // List<Widget> topBarContent = [];

  // @override
  // void didChangeDependencies() {

  //   if (!widget.isOpen) {

  //     Future.delayed(Duration(milliseconds: 100), () {
  //       setState(() {
  //         topBarContent = [
  //           const SizedBox(height: 40,),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               IconButton(
  //                 onPressed: () {
  //                   widget.setHeight();
  //                 },
  //                 icon: const Icon(Icons.menu, color: colors.lightThemeTextColor,)
  //               ),
  //               Text(widget.pageTitle, style: const TextStyle(fontSize: 32, color: colors.lightThemeTextColor),),
  //               const SizedBox(width: 50),
  //             ]
  //           ),
  //           const SizedBox(height: 30,),
  //           const Row(children: [
  //             Text("Base Currency", style: const TextStyle(fontSize: 18, color: colors.lightThemeTextColor),),
  //             // BaseDropdown(),
  //           ],),
  //           const SizedBox(height: 5,),
  //           const Row(children: [
  //             Text("Theme", style: const TextStyle(fontSize: 18, color: colors.lightThemeTextColor),),
  //           ],),
  //           const SizedBox(height: 5,),
  //           GestureDetector(
  //             onTap: () {},
  //             child: Container(
  //               alignment: Alignment.centerLeft,
  //               child: const Text("About App", style: const TextStyle(fontSize: 18, color: colors.lightThemeTextColor),),
  //             ),
  //           ),
  //         ];
  //       });
  //     });
  //   } else {

  //     setState(() {
  //       topBarContent = [
  //         const SizedBox(height: 40,),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             IconButton(
  //               onPressed: () {
  //                 widget.setHeight();
  //               },
  //               icon: const Icon(Icons.menu, color: colors.lightThemeTextColor,)
  //             ),
  //             Text(widget.pageTitle, style: const TextStyle(fontSize: 32, color: colors.lightThemeTextColor),),
  //             const SizedBox(width: 50),
  //           ]
  //         ),
  //       ];
  //     });
      
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: widget.isOpen ? 500 : 120,
        child: AppBar(
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            clipBehavior: Clip.antiAlias,
            // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              gradient: colors.topNavGradient,
            ),
            child: Column(children: [
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      widget.setHeight();
                    },
                    icon: Icon(widget.isOpen ? Icons.close_rounded : Icons.menu, color: colors.lightThemeTextColor,)
                  ),
                  Text(widget.pageTitle, style: const TextStyle(fontSize: 32, color: colors.lightThemeTextColor),),
                  const SizedBox(width: 50),
                ]
              ),
              if (widget.isOpen) const SizedBox(height: 30,),
              if (widget.isOpen) Row(children: [
                const SizedBox(width: 8,),
                SizedBox(width: 30, child: Image.asset("images/coin.png")),
                const SizedBox(width: 13,),
                const Text("Base Currency:", style: TextStyle(fontSize: 16, color: colors.lightThemeTextColor),),
                const SizedBox(width: 10,),
                const BaseDropdown(),
              ],),
              if (widget.isOpen) const SizedBox(height: 20,),
              if (widget.isOpen) Row(children: [
                const SizedBox(width: 12,),
                SizedBox(width: 25, child: Image.asset("images/theme.png")),
                const SizedBox(width: 15,),
                const Text("Theme:", style: TextStyle(fontSize: 16, color: colors.lightThemeTextColor),),
                const ThemeSelection(),
              ],),
              if (widget.isOpen) const SizedBox(height: 13,),
              if (widget.isOpen) GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const SizedBox(width: 12,),
                      SizedBox(width: 25, child: Image.asset("images/about.png")),
                      const SizedBox(width: 15,),
                      const Text("About App", style: TextStyle(fontSize: 16, color: colors.lightThemeTextColor),),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        )
    );
  }
}


/*

The below code should wrap TopBar widget:

  double height = 90;
  bool isOpen = false;

  void setHeight() {
    setState(() {
      if (isOpen) {
        isOpen = !isOpen;
        Future.delayed(const Duration(milliseconds: 300), () {
          height = 90;
        });
      } else {
        height = 300;
        isOpen = !isOpen;
      }
    });
  }

appBar: PreferredSize(
  preferredSize: Size.fromHeight(height),
  child: TopBar(
    pageTitle: "Title",
    isOpen: isOpen,
    setHeight: setHeight,
  ),
),

*/