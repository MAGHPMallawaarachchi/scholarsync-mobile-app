import 'package:flutter/material.dart';
import '../../../../themes/palette.dart';
import 'change_theme_button.dart';

class SettingsWidget extends StatefulWidget {
  final IconData leftIcon;
  final bool isSwitched;
  final String text;
  final Function(bool) onToggle;
  final bool isSwitch;

  const SettingsWidget({
    required this.leftIcon,
    required this.isSwitched,
    required this.text,
    required this.onToggle,
    required this.isSwitch,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        color: Theme.of(context).dialogBackgroundColor,
        boxShadow: const [
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
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          if (widget.isSwitch)
            Switch(
              value: widget.isSwitched,
              onChanged: widget.onToggle,
              activeColor: CommonColors.secondaryGreenColor,
            ),
          if (!widget.isSwitch) const ChangeThemeButton(),
        ],
      ),
    );
  }
}
