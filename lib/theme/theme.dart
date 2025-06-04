import 'package:flutter/material.dart';

final themeColor = Color(0xFF304FFE);
final themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: themeColor,
    brightness: Brightness.light,
    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(6.0),
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: FilledButton.styleFrom(
      side: BorderSide(
        color: themeColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(6.0),
      ),
    ),
  ),
);
