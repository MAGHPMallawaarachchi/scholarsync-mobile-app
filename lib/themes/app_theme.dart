import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';

TextTheme getTextTheme(BuildContext context, bool isDarkTheme) {
  return Theme.of(context).textTheme.copyWith(
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: isDarkTheme
              ? PaletteDarkMode.titleColor
              : PaletteLightMode.titleColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isDarkTheme
              ? PaletteDarkMode.titleColor
              : PaletteLightMode.titleColor,
        ),
      );
}

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    scaffoldBackgroundColor: isDarkTheme
        ? PaletteDarkMode.backgroundColor
        : PaletteLightMode.backgroundColor,
    colorScheme: isDarkTheme
        ? const ColorScheme.dark(
            primary: PaletteDarkMode.titleColor,
          )
        : const ColorScheme.light(
            primary: PaletteLightMode.titleColor,
          ),
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkTheme
          ? PaletteDarkMode.backgroundColor
          : PaletteLightMode.backgroundColor,
      elevation: 0,
    ),
    textTheme: getTextTheme(context, isDarkTheme),
  );
}
