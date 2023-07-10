import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_app/utils/app_colors.dart';

class AppTheme {
  AppTheme._();
  static final AppTheme _theme = AppTheme._();
  factory AppTheme() => _theme;
  ThemeData appTheme = ThemeData(
    useMaterial3: true,
    textTheme:
        TextTheme(displayMedium: GoogleFonts.poppins(color: Colors.white)),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.appColor),
    scaffoldBackgroundColor: AppColors.appColor,
    primaryColor: AppColors.containerBackground,
  );
}
