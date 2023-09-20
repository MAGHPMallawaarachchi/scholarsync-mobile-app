import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/themes/palette.dart';

class CustomAppBar extends StatelessWidget {
  final bool? leftIcon;
  final String? leftIconToolTip;
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final bool titleCenter;
  final VoidCallback onPressedListButton;

  const CustomAppBar({
    Key? key,
    this.leftIcon,
    this.leftIconToolTip,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    required this.titleCenter,
    required this.onPressedListButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      centerTitle: titleCenter,
      leading: leftIcon != null
          ? IconButton(
              icon: Icon(
                PhosphorIcons.bold.arrowLeft,
                color: CommonColors.secondaryGreenColor,
                size: 28.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            PhosphorIcons.bold.list,
            color: CommonColors.secondaryGreenColor,
            size: 28.0,
          ),
          onPressed: onPressedListButton,
        )
      ],
    );
  }
}
