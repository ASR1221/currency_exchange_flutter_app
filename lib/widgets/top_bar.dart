import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "../constants/colors.dart" as colors;
import "base_dropdown.dart";
import "theme_selection.dart";
import "../pages/about_page.dart";

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    required this.pageTitle,
    required this.isOpen,
    required this.setHeight
  });

  final String pageTitle;
  final bool isOpen;
  final Function() setHeight;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  List<Widget> topBarContent = [];

  @override
  void initState() {
    super.initState();

    topBarContent = [
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
    ];
  }

  @override
  void didUpdateWidget(TopBar oldWidget) {

    if (widget.isOpen) {

      Future.delayed(const Duration(milliseconds: 150), () {
        setState(() {
          topBarContent = [
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
            const SizedBox(height: 30,),
            Row(children: [
              const SizedBox(width: 9,),
              SizedBox(width: 30, child: Image.asset("images/coin.png")),
              const SizedBox(width: 13,),
              const Text("Base Currency:", style: TextStyle(fontSize: 16, color: colors.lightThemeTextColor),),
              const SizedBox(width: 10,),
              const BaseDropdown(),
            ],),
            const SizedBox(height: 20,),
            Row(children: [
              const SizedBox(width: 12,),
              SizedBox(width: 25, child: Image.asset("images/theme.png")),
              const SizedBox(width: 15,),
              const Text("Theme:", style: TextStyle(fontSize: 16, color: colors.lightThemeTextColor),),
              const ThemeSelection(),
            ],),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
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
          ];
        });
      });
    } else {

      setState(() {
        topBarContent = [
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
        ];
      });
      
    }
    super.didUpdateWidget(oldWidget);
  }

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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              gradient: colors.topNavGradient,
            ),
            child: Column(children: topBarContent),
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