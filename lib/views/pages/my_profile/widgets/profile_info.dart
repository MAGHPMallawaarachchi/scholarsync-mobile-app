import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/constants/image_constants.dart';
import 'package:scholarsync/themes/palette.dart';

import '../../../widgets/circular_icon_button.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      height: 220,
      decoration: BoxDecoration(
        color: PaletteLightMode.primaryGreenColor,
        border: Border.all(
          color: PaletteLightMode.primaryGreenColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          ImageConstants.kuppiImg1), // Add your image path here
                    ),
                    CircularIconButton(
                      buttonSize: 25,
                      iconAsset: IconConstants.cameraIcon,
                      iconColor: PaletteLightMode.whiteColor,
                      buttonColor: PaletteLightMode.secondaryGreenColor,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'ATD Gamage - 24598',
                  style: TextStyle(
                    fontSize: 20,
                    color: PaletteLightMode.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Bsc.(Hons) in Software Engineering - 24598',
                  style: TextStyle(
                    color: PaletteLightMode.whiteColor,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'Batch - 21.1',
                  style: TextStyle(
                    color: PaletteLightMode.whiteColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
