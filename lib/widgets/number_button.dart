import 'package:flutter/material.dart';

import "../constants/colors.dart" as colors;

class DialNumberButton extends StatelessWidget {
  const DialNumberButton({super.key, required this.btnNumber});

  final String btnNumber;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: colors.gradientBorderColor, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(btnNumber),
        ),
      ),
    );
  }
}