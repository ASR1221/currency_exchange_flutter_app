import 'package:flutter/material.dart';

import '../extensions/custom_theme_extension.dart';
import "../constants/colors.dart" as colors;

class BackGroundGradientWrapper extends StatelessWidget {
  const BackGroundGradientWrapper({super.key, required this.childApp});

  final Widget childApp;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomThemeExtension>();

    return Container(
      decoration: BoxDecoration(
        gradient: customTheme?.bgGradient,
      ),
      child: childApp,
    );
  }
}
