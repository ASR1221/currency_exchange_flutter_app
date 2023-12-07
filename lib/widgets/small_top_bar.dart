import 'package:flutter/material.dart';

import '../extensions/custom_theme_extension.dart';

class SmallTopBar extends StatelessWidget {
  const SmallTopBar({super.key, this.title = "", required this.changePage});

  final String title;
  final Function(int x) changePage;


  @override
  Widget build(BuildContext context) {

    final customTheme = Theme.of(context).extension<CustomThemeExtension>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () {
            changePage(0);
          },
          child: Row(children: [
            Icon(Icons.arrow_back_rounded, color: customTheme?.textColor,),
            Text("Back", style: TextStyle(color: customTheme?.textColor),),
          ],),
        ),
        title: title == "" ? null : Text(title),
      ),
    );
  }
}
