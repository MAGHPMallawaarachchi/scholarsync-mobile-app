import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../themes/palette.dart';

class NavigationItem extends StatefulWidget {
  final bool isSelected;
  final IconData iconName;
  final VoidCallback onTap;

  const NavigationItem({
    super.key,
    required this.isSelected,
    required this.iconName,
    required this.onTap,
  });

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  @override
  Widget build(BuildContext context) {
    final iconColor = widget.isSelected
        ? CommonColors.whiteColor
        : CommonColors.secondaryGreenColor;
    final lineColor = widget.isSelected
        ? CommonColors.secondaryGreenColor
        : CommonColors.transparentColor;

    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.iconName,
              color: iconColor,
              size: 28,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: lineColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
