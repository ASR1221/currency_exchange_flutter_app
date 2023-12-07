import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_controller.dart';
import "../constants/colors.dart" as colors;

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ThemeSelectButton(themeId: 1),
        ThemeSelectButton(themeId: 2),
        ThemeSelectButton(themeId: 0),
      ],
    );
  }
}

class ThemeSelectButton extends StatelessWidget {
  const ThemeSelectButton({
    super.key,
    required this.themeId,
  });

  final int themeId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderController>(
      builder: (context, provider, child) => GestureDetector(
        onTap: () {
          provider.setTheme(themeId);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: provider.currentThemeId != themeId ? null : colors.bottomNavBarActiveColor.withOpacity(0.8),
                  boxShadow: provider.currentThemeId != themeId ? null : [BoxShadow(color: colors.bottomNavBarActiveColor.withOpacity(.3), blurRadius: 4)]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 9,
                      height: 18,
                      decoration: BoxDecoration(
                        color: themeId == 2 ? colors.lightThemeTextColor : colors.darkThemeTextColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(9), bottomLeft: Radius.circular(9)),
                      ),
                    ),
                    Container(
                      width: 9,
                      height: 18,
                      decoration: BoxDecoration(
                        color: themeId == 1 ? colors.darkThemeTextColor : colors.lightThemeTextColor,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(9), bottomRight: Radius.circular(9)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5,),
              Text(themeId == 0 ? "System" : themeId == 1 ? "Light" : "Dark", style: TextStyle(fontSize: 12, color: colors.lightThemeTextColor),),
            ],
          ),
        ),
      ),
    );
  }
}
