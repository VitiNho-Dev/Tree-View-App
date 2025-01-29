import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_view_app/ui/core/themes/colors.dart';

abstract final class AppTheme {
  static final _textTheme = TextTheme(
    titleMedium: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.grey500,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.grey600,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBlue,
      titleTextStyle: _textTheme.titleSmall,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors.grey100),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors.grey100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors.grey100),
      ),
      filled: true,
      fillColor: AppColors.grey100,
      prefixIconColor: AppColors.grey500,
      hintStyle: _textTheme.labelSmall,
    ),
  );
}
