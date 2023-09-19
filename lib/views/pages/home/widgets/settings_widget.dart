import 'package:flutter/material.dart';
import '../../../../themes/palette.dart';

class SettingsWidget extends StatefulWidget {
  final IconData leftIcon;
  final bool isSwitched;
  final String text;
  final Function(bool) onToggle;

  const SettingsWidget({
    required this.leftIcon,
    required this.isSwitched,
    required this.text,
    required this.onToggle,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
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
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: PaletteLightMode.textColor,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Switch(
            value: widget.isSwitched,
            onChanged: widget.onToggle,
            activeTrackColor: CommonColors.secondaryGreenColor,
            activeColor: CommonColors.secondaryGreenColor,
          ),
        ],
      ),
    );
  }
}
