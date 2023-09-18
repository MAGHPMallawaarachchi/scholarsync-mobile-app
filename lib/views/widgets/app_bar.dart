import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholarsync/themes/palette.dart';

class UIConstants {
  static AppBar appBar({
    VoidCallback? onLeftIconPressed,
    String? leftIcon,
    String? leftIconToolTip,
    required String title,
    required double fontSize,
    required FontWeight fontWeight,
    required bool titleCenter,
    required String rightIcon,
    required VoidCallback onRightIconPressed,
  }) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(
        color: PaletteLightMode.titleColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      centerTitle: titleCenter,
      leading: leftIcon != null
          ? IconButton(
              icon: SvgPicture.asset(
                leftIcon,
                colorFilter: const ColorFilter.mode(
                  PaletteLightMode.secondaryGreenColor,
                  BlendMode.srcIn,
                ),
                width: 40,
                height: 40,
              ),
              tooltip: leftIconToolTip,
              onPressed: onLeftIconPressed,
            )
          : null,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            rightIcon,
            colorFilter: const ColorFilter.mode(
              PaletteLightMode.secondaryGreenColor,
              BlendMode.srcIn,
            ),
            width: 40,
            height: 40,
          ),
          tooltip: 'Menu',
          onPressed: onRightIconPressed,
        ),
      ],
    );
  }
}
