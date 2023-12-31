import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

TextTheme getTextTheme(BuildContext context, bool isDarkTheme) {
  return Theme.of(context).textTheme.copyWith(
        //app bar title
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: isDarkTheme
              ? PaletteDarkMode.titleColor
              : PaletteLightMode.titleColor,
        ),
        //sub headings
        headlineMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDarkTheme
              ? PaletteDarkMode.textColor
              : PaletteLightMode.textColor,
        ),
        displayLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isDarkTheme
              ? PaletteDarkMode.textColor
              : PaletteLightMode.textColor,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isDarkTheme
              ? PaletteDarkMode.titleColor
              : PaletteLightMode.titleColor,
        ),
        //view all
        displaySmall: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: CommonColors.secondaryGreenColor,
        ),
        //search bar text
        displayMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDarkTheme
              ? PaletteDarkMode.secondaryTextColor
              : PaletteLightMode.secondaryTextColor,
        ),
        bodySmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isDarkTheme
              ? PaletteDarkMode.secondaryTextColor
              : PaletteLightMode.secondaryTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isDarkTheme
              ? PaletteDarkMode.textColor
              : PaletteLightMode.textColor,
        ),
        labelSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isDarkTheme
              ? PaletteDarkMode.textColor
              : PaletteLightMode.textColor,
        ),
      );
}

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    secondaryHeaderColor:
        isDarkTheme ? PaletteDarkMode.textColor : PaletteLightMode.textColor,
    scaffoldBackgroundColor: isDarkTheme
        ? PaletteDarkMode.backgroundColor
        : PaletteLightMode.backgroundColor,
    colorScheme: isDarkTheme
        ? const ColorScheme.dark(
            primary: PaletteDarkMode.containerColor,
          )
        : const ColorScheme.light(
            primary: PaletteLightMode.containerColor,
          ),
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkTheme
          ? PaletteDarkMode.backgroundColor
          : PaletteLightMode.backgroundColor,
      elevation: 0,
    ),
    dialogBackgroundColor: isDarkTheme
        ? PaletteDarkMode.containerColor
        : PaletteLightMode.containerColor,
    dividerColor: isDarkTheme
        ? PaletteLightMode.secondaryTextColor
        : PaletteDarkMode.secondaryTextColor,
    listTileTheme: isDarkTheme
        ? const ListTileThemeData(
            textColor: PaletteDarkMode.textColor,
          )
        : const ListTileThemeData(
            textColor: PaletteLightMode.textColor,
          ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDarkTheme
          ? PaletteDarkMode.containerColor
          : PaletteLightMode.containerColor,
      hintStyle: Theme.of(context).textTheme.displayMedium,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: isDarkTheme
                ? PaletteDarkMode.containerColor
                : PaletteLightMode.containerColor,
            width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: CommonColors.secondaryGreenColor, width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: getTextTheme(context, isDarkTheme),
  );
}
