import 'package:flutter/material.dart';

import "../constants/colors.dart" as colors;

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key, required this.selectedIndex, required this.changePage});

  int selectedIndex;
  final Function(int x) changePage;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: const BoxDecoration(
              gradient: colors.bottomNavGradient
            ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: widget.selectedIndex,
            selectedItemColor: colors.bottomNavBarActiveColor,
            unselectedItemColor: colors.lightThemeTextColor,
            onTap: widget.changePage,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox(width: 25, child: Image.asset("images/star.png")),
                activeIcon: SizedBox(width: 25, child: Image.asset("images/star-filled.png")),
                label: 'Starred',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(width: 25, child: Image.asset("images/coins.png")),
                activeIcon: SizedBox(width: 25, child: Image.asset("images/coins-filled.png")),
                label: 'Currencies',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(width: 25, child: Image.asset("images/convert.png")),
                activeIcon: SizedBox(width: 25, child: Image.asset("images/convert-filled.png")),
                label: 'Converter',
              ),
            ],
          ),
        ),
      ),
    );
  }
}