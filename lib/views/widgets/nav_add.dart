import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/icon_constants.dart';
import '../../themes/palette.dart';

class NavigationAddItem extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationAddItem({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<NavigationAddItem> createState() => _NavigationAddItemState();
}

class _NavigationAddItemState extends State<NavigationAddItem> {
  @override
  Widget build(BuildContext context) {
    final circleColor = widget.isSelected
        ? CommonColors.secondaryGreenColor
        : CommonColors.whiteColor;
    final iconColor = widget.isSelected
        ? CommonColors.whiteColor
        : CommonColors.primaryGreenColor;
    final lineColor = widget.isSelected
        ? CommonColors.transparentColor
        : CommonColors.transparentColor;

    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  IconConstants.addButtonIcon,
                  colorFilter: ColorFilter.mode(
                    iconColor,
                    BlendMode.srcIn,
                  ),
                  width: 10,
                  height: 10,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
