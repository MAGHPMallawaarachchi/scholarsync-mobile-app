import 'package:flutter/material.dart';
import '../../../../themes/palette.dart';

class NotificationWidget extends StatefulWidget {
  final IconData leftIcon;
  final String text;
  final String subtitle;

  const NotificationWidget({
    required this.leftIcon,
    required this.text,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: CommonColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: CommonColors.shadowColor,
            offset: Offset(8, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                widget.leftIcon,
                size: 28.0,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: PaletteLightMode.textColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: PaletteLightMode.secondaryTextColor,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
