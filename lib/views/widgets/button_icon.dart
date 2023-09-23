import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final Color backgroundColor;
  final Color? iconColor;
  final double? size;
  final bool isSelected;

  const ButtonIcon({
    this.onTap,
    this.icon,
    this.backgroundColor = Colors.transparent,
    this.iconColor,
    this.size,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: icon != null
            ? Icon(
                icon!,
                size: size,
                color: iconColor,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
