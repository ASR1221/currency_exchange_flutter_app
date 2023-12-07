import 'package:flutter/material.dart';

@immutable
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  const CustomThemeExtension({
    required this.bgGradient,
    required this.borderColor,
    required this.textColor,
  });

  final Gradient? bgGradient;
  final Color? borderColor;
  final Color? textColor;

  @override
  CustomThemeExtension copyWith({Color? brandColor, Color? danger}) {
    return CustomThemeExtension(
      bgGradient: bgGradient ?? this.bgGradient,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  CustomThemeExtension lerp(CustomThemeExtension? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      bgGradient: bgGradient,
      borderColor: Color.lerp(borderColor ?? Colors.black, other.borderColor ?? Colors.black, t),
      textColor: Color.lerp(textColor ?? Colors.black, other.textColor ?? Colors.black, t),
    );
  }
}