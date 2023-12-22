import 'package:flutter/material.dart';

import "../constants/colors.dart" as colors;

class DialNumberButton extends StatelessWidget {
  const DialNumberButton({super.key, required this.btnNumber, required this.onTapHandler});

  final String btnNumber;
  final void Function() onTapHandler;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: colors.gradientBorderColor, width: 1),
          borderRadius: BorderRadius.circular(11)
        ),
        child: Center(
          child: btnNumber == "" ? const Icon(Icons.backspace_rounded, color: colors.gradientBorderColor, size: 28,) :
          Text(btnNumber, style: const TextStyle(color: colors.gradientBorderColor, fontSize: 28),),
        ),
      ),
    );
  }
}