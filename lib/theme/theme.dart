import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class ChecklistTheme {
  static final themeColor = Color(0xFF304FFE);

  static final themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: themeColor,
      brightness: Brightness.light,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    ),

    // textTheme: GoogleFonts.interTextTheme(),
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

  static final titleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    // fontFamily: GoogleFonts.inter.toString(),
    height: 1.2,
    letterSpacing: 0.2,
  );

  static final itemTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    // fontFamily: GoogleFonts.inter.toString(),
    height: 1.2,
    letterSpacing: 0.2,
  );

  static final subtitleTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    // fontFamily: GoogleFonts.inter.toString(),
    color: Colors.grey.shade500,
  );
}
