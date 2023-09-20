import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholarsync/themes/app_theme.dart';
import 'package:scholarsync/themes/palette.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
        activeColor: CommonColors.secondaryGreenColor,
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        });
  }
}
