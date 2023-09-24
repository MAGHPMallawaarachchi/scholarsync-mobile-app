import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double textSize;
  final double height;
  final Color labelColor;

  const CustomElevatedButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.backgroundColor = CommonColors.secondaryGreenColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
    this.textSize = 16,
    this.height = 35,
    this.labelColor = CommonColors.whiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: padding,
          backgroundColor: backgroundColor,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: textSize, color: labelColor),
        ),
      ),
    );
  }
}
