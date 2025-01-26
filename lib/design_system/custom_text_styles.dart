import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_view_app/design_system/colors.dart';

class CustomTextStyles {
  static TextStyle get title => GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: CustomColors.background,
      );
}
