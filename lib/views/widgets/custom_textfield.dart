import 'package:flutter/material.dart';
import 'package:scholarsync/views/widgets/button_icon.dart';

class CustomTextField extends StatelessWidget {
  final String firstLine;
  final String? secondPartFirstline;
  final String? secondLine;
  final String? thirdLine;
  final TextStyle firstLineStyle;
  final TextStyle? secondLineStyle;
  final TextStyle? thirdLineStyle;
  final TextStyle? secondPartFirstLineStyle;

  final TextEditingController controller;
  final VoidCallback? ontapBox;
  final VoidCallback? ontapleftIcon;
  final VoidCallback? ontaprightIcon;
  final String? leftIcon;
  final String? rightIcon;
  final double? leftIconScale;
  final double? rightIconScale;
  final Color? leftIconColor;
  final Color? rightIconColor;
  final Color borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final double boxwidth;
  final double boxheight;
  final double borderRadius;
  final double padding;

  const CustomTextField({
    super.key,
    required this.firstLine,
    this.secondPartFirstline,
    this.secondLine,
    this.thirdLine,
    required this.firstLineStyle,
    this.secondLineStyle,
    this.thirdLineStyle,
    this.secondPartFirstLineStyle,
    required this.controller,
    this.ontapBox,
    this.ontapleftIcon,
    this.ontaprightIcon,
    this.leftIcon,
    this.rightIcon,
    this.leftIconScale,
    this.rightIconScale,
    this.leftIconColor,
    this.rightIconColor,
    required this.borderColor,
    required this.borderWidth,
    this.backgroundColor,
    required this.boxwidth,
    required this.boxheight,
    required this.borderRadius,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontapBox,
      child: Container(
        width: boxwidth,
        height: boxheight,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Row(
          children: [
            if (leftIcon != null)
              ButtonIcon(
                onTap: ontapleftIcon,
                icon: leftIcon,
                iconColor: leftIconColor,
                size: leftIconScale,
              ),
            const SizedBox(width: 8),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      if (leftIcon != null)
                        TextSpan(
                          text: firstLine,
                          style: firstLineStyle,
                          children: [
                            if (secondPartFirstLineStyle != null) ...[
                              const TextSpan(text: ' '),
                              TextSpan(
                                  text: secondPartFirstline,
                                  style: secondPartFirstLineStyle),
                            ],
                          ],
                        ),
                      if (secondLine != null) ...[
                        const TextSpan(text: '\n'),
                        TextSpan(text: secondLine, style: secondLineStyle),
                      ],
                      if (thirdLine != null) ...[
                        const TextSpan(text: '\n'),
                        TextSpan(text: thirdLine, style: thirdLineStyle),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (rightIcon != null)
              ButtonIcon(
                onTap: ontaprightIcon,
                icon: rightIcon,
                iconColor: rightIconColor,
                size: rightIconScale,
              ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
