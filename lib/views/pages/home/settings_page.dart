import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/views/widgets/custom_textfield.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
// import 'package:scholarsync/theme/app_theme.dart';
// import 'package:scholarsync/features/view/home_page.dart';

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
        onLeftIconPressed: () {},
        onRightIconPressed: () {},
      ),
      backgroundColor: PaletteLightMode.backgroundColor,
      //body
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "inter",
                color: PaletteLightMode.titleColor,
              ),
            ),
            const SizedBox(height: 10),
            //settings widget 01

            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: PaletteLightMode.shadowColor,
                    offset: Offset(8, 8),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: CustomTextField(
                  firstLine: "Receive Notifications",
                  firstLineStyle: const TextStyle(
                    fontSize: 14,
                    color: PaletteLightMode.titleColor,
                  ),
                  controller: TextEditingController(),
                  ontapBox: () {
                    // onTap function for the Box
                  },
                  ontapleftIcon: () {
                    // onTap function for leftIcon
                  },
                  ontaprightIcon: () {
                    // onTap function for rightIcon
                  },
                  leftIcon: IconConstants.bellOutlinedIcon,
                  rightIcon: IconConstants.toggleOffIcon,
                  leftIconScale: 50,
                  rightIconScale: 60,
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  backgroundColor: PaletteLightMode.backgroundColor,
                  boxwidth: 369.84,
                  boxheight: 75,
                  borderRadius: 10,
                  padding: 16,
                ),
              ),
            ),

// Add spacing between the CustomTextField and the new Text widget

            const SizedBox(height: 20),
            const Text(
              'Theme',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "inter",
                color: PaletteLightMode.titleColor,
              ),
            ),
//settings widget 02

            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: PaletteLightMode.shadowColor,
                    offset: Offset(8, 8),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: CustomTextField(
                  firstLine: "Dark Mode",
                  firstLineStyle: const TextStyle(
                    fontSize: 14,
                    color: PaletteLightMode.titleColor,
                  ),
                  controller: TextEditingController(),
                  ontapBox: () {
                    // onTap function for the Box
                  },
                  ontapleftIcon: () {
                    // onTap function for leftIcon
                  },
                  ontaprightIcon: () {
                    // onTap function for rightIcon
                  },
                  leftIcon: IconConstants.moonIcon,
                  rightIcon: IconConstants.toggleOffIcon,
                  leftIconScale: 35,
                  rightIconScale: 60,
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  backgroundColor: PaletteLightMode.backgroundColor,
                  boxwidth: 369.84,
                  boxheight: 75,
                  borderRadius: 10,
                  padding: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
//settings widget 03
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: PaletteLightMode.shadowColor,
                    offset: Offset(8, 8),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: CustomTextField(
                  firstLine: "Auto Dark Mode",
                  firstLineStyle: const TextStyle(
                    fontSize: 14,
                    color: PaletteLightMode.titleColor,
                  ),
                  controller: TextEditingController(),
                  ontapBox: () {
                    // onTap function for the Box
                  },
                  ontapleftIcon: () {
                    // onTap function for leftIcon
                  },
                  ontaprightIcon: () {
                    // onTap function for rightIcon
                  },
                  leftIcon: IconConstants.darkNightModeIcon,
                  rightIcon: IconConstants.toggleOffIcon,
                  leftIconScale: 50,
                  rightIconScale: 60,
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  backgroundColor: Colors.white,
                  boxwidth: 369.84,
                  boxheight: 75,
                  borderRadius: 10,
                  padding: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
