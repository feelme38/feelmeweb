import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

class AppTheme {
  static ThemeData dataLight = ThemeData().copyWith(
      textTheme: TextTheme(
          //task title
          displayLarge: GoogleFonts.notoSans(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.18),
          displayMedium:
              GoogleFonts.notoSans(fontSize: 18, color: AppColor.textGrey),
          displaySmall:
              GoogleFonts.notoSans(fontSize: 12, color: AppColor.textGreyLight),
          headlineLarge: GoogleFonts.notoSans(fontSize: 28),
          //for buttons, text-fields
          headlineMedium: GoogleFonts.notoSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.primary),
          headlineSmall: GoogleFonts.notoSans(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          bodyLarge: GoogleFonts.notoSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
          bodyMedium: GoogleFonts.notoSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.textGreyDark),
          bodySmall: GoogleFonts.notoSans(fontSize: 12, color: Colors.grey)));
}
