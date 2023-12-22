import 'package:flutter/material.dart';

import "../constants/colors.dart" as colors;

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key, required this.selectedIndex, required this.changePage});

  int selectedIndex;
  final Function(int x) changePage;

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
            currentIndex: selectedIndex,
            selectedItemColor: colors.bottomNavBarActiveColor,
            unselectedItemColor: colors.lightThemeTextColor,
            onTap: changePage,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox(width: 25, child: Image.asset("images/home.png")),
                activeIcon: SizedBox(width: 25, child: Image.asset("images/home-filled.png")),
                label: 'Home',
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
              BottomNavigationBarItem(
                icon: SizedBox(width: 25, child: Image.asset("images/news.png")),
                activeIcon: SizedBox(width: 25, child: Image.asset("images/news-filled.png")),
                label: 'News',
              ),
            ],
          ),
        ),
      ),
    );
  }
}