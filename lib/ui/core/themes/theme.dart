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
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: AppTheme._textTheme,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.darkBlue),
  );
}
