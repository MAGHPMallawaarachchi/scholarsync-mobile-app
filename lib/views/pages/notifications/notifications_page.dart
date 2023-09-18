import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/views/widgets/custom_textfield.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        title: 'Notifications',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        titleCenter: false,
        rightIcon: IconConstants.hamburgerMenuIcon,
        onRightIconPressed: () {},
      ),
      backgroundColor: PaletteLightMode.backgroundColor,
      //body
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "inter",
                    color: PaletteLightMode.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                // Notification 01
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
                      firstLine: "Lecture hall allocation",
                      secondPartFirstline: "has been updated",
                      thirdLine: "20 minutes ago",
                      firstLineStyle: const TextStyle(
                          fontSize: 13, color: PaletteLightMode.textColor),
                      thirdLineStyle: const TextStyle(
                          fontSize: 9,
                          color: PaletteLightMode.secondaryTextColor),
                      secondPartFirstLineStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
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
                      leftIcon: IconConstants.calendarIcon,
                      // rightIcon: IconConstants.moonIcon,
                      leftIconScale: 50,
                      rightIconScale: 50,
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
                const SizedBox(height: 20),
//Notification 02
                const Text(
                  'Yesterday',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "inter",
                    color: PaletteLightMode.textColor,
                  ),
                ),
                const SizedBox(height: 10),

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
                      firstLine: "There are upcoming",
                      secondPartFirstline: "lectures",
                      thirdLine: "30 minutes ago",
                      firstLineStyle: const TextStyle(
                          fontSize: 13, color: PaletteLightMode.textColor),
                      thirdLineStyle: const TextStyle(
                          fontSize: 9,
                          color: PaletteLightMode.secondaryTextColor),
                      secondPartFirstLineStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
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
                      // rightIcon: IconConstants.moonIcon,
                      leftIconScale: 50,
                      rightIconScale: 50,
                      borderColor: PaletteLightMode.transparentColor,
                      borderWidth: 0,
                      backgroundColor: Colors.white,
                      boxwidth: 369.84,
                      boxheight: 75,
                      borderRadius: 10,
                      padding: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Notification 03
                const Text(
                  'Previous',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "inter",
                    color: PaletteLightMode.textColor,
                  ),
                ),
                const SizedBox(height: 10),
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
                      firstLine: "There are upcoming",
                      secondPartFirstline: "lectures",
                      thirdLine: "30 minutes ago",
                      firstLineStyle: const TextStyle(
                          fontSize: 13, color: PaletteLightMode.textColor),
                      thirdLineStyle: const TextStyle(
                          fontSize: 9,
                          color: PaletteLightMode.secondaryTextColor),
                      secondPartFirstLineStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
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
                      // rightIcon: IconConstants.moonIcon,
                      leftIconScale: 50,
                      rightIconScale: 50,
                      borderColor: PaletteLightMode.transparentColor,
                      borderWidth: 0,
                      backgroundColor: Colors.white,
                      boxwidth: 369.84,
                      boxheight: 75,
                      borderRadius: 10,
                      padding: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            )),
      ),
    );
  }
}
