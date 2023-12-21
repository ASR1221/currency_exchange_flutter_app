import 'package:flutter/material.dart';
import 'dart:math' as math;

// Text
const lightThemeTextColor = Color(0xff111111);
const darkThemeTextColor = Color(0xfff9fafb);


// Main background
const lightThemeBgGradient = LinearGradient(
  begin: Alignment.topRight,
  colors: [
    Color(0xfff9fafb),
    Color(0xfff2f2f2),
  ],
);

const darkThemeBgGradient = LinearGradient(
  transform: GradientRotation(3*math.pi/4),
  stops: [
    0.2,
    0.3,
    0.7,
    1,
  ],
  colors: [
    Color(0xff02051D),
    Color(0xff0F1541),
    Color(0xff02051D),
    Color.fromARGB(255, 3, 8, 49),
  ],
);


// Borders
const lightThemeBorderColor = Color(0xff275678);
const darkThemeBorderColor = Color(0xff8587C3);
const gradientBorderColor = Color(0xff02051D);


// Search bar
const searchBarColor = Color(0x590C4477);


// bottom navbar active
Color bottomNavBarActiveColor = Colors.cyan;


// Gradients
const topNavGradient = LinearGradient(
  transform: GradientRotation(math.pi/4),
  colors: [Color(0xff7250EE), Color(0xff73ACE1)],
);


const bottomNavGradient = LinearGradient(
  transform: GradientRotation(3*math.pi/4 + 2),
  stops: [0.4, 1],
  colors: [Color(0xff7250EE), Color(0xff73ACE1)],
);


const baseDropdownGradient = LinearGradient(
  begin: Alignment.topLeft,
  colors: [
    Color.fromARGB(255, 111, 220, 230),
    Color.fromARGB(211, 143, 207, 217),
    Color.fromARGB(200, 143, 207, 217)
  ],
);


const loadingPlaceholderGradient = LinearGradient(
  begin: Alignment.centerLeft,
  colors: [
    Color.fromARGB(222, 94, 94, 94),
    Color.fromARGB(207, 138, 138, 138),
  ],
);


const walletCardGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.4, 1],
  colors: [
    Color.fromARGB(238, 114, 80, 238),
    Color.fromARGB(88, 115, 172, 225),
  ],
);


const longButtonGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.5, 1],
  colors: [
    Colors.cyan,
    Color(0xdd368FCF),
  ],
);


// class effect to test
// ClipRRect(
//   borderRadius:BorderRadius.all(Radius.circular(25)),
//   child: BackdropFilter(
//     filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
//     child: Container(
//       width: 450,
//       height: 250,
//       decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.1),
//           borderRadius:
//               const BorderRadius.all(Radius.circular(25))),
//     ),
//   ),
// ),