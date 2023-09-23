import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final double buttonSize;
  final IconData iconAsset;
  final Color iconColor;
  final Color buttonColor;
  final VoidCallback onPressed;

  const CircularIconButton({
    Key? key,
    required this.buttonSize,
    required this.iconAsset,
    required this.iconColor,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(buttonSize / 2.0),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            iconAsset,
            size: buttonSize * 0.5,
          ),
        ),
      ),
    );
  }
}
