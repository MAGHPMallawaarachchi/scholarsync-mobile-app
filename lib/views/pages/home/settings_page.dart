import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'widgets/settings_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        title: 'Settings',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        titleCenter: true,
        rightIcon: IconConstants.hamburgerMenuIcon,
        leftIcon: IconConstants.leftArrowIcon,
        leftIconToolTip: 'go to the next page',
        onLeftIconPressed: () {
          Navigator.pop(context);
        },
        onRightIconPressed: () {},
      ),
      backgroundColor: PaletteLightMode.backgroundColor,
      //body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'General',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "inter",
              fontWeight: FontWeight.w600,
              color: PaletteLightMode.textColor,
            ),
          ),
          const SizedBox(height: 20),
          //settings widget 01
          SettingsWidget(
            leftIcon: PhosphorIcons.light.bell,
            text: 'Receive Notifications',
            onToggle: (value) {},
            isSwitched: false,
          ),
          const SizedBox(height: 20),
          const Text(
            'Theme',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "inter",
              fontWeight: FontWeight.w600,
              color: PaletteLightMode.textColor,
            ),
          ),
          const SizedBox(height: 20),
          SettingsWidget(
            leftIcon: PhosphorIcons.light.moon,
            text: 'Dark Mode',
            onToggle: (value) {},
            isSwitched: false,
          ),
        ]),
      ),
    );
  }
}
