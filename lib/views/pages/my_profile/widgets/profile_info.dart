import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/constants/image_constants.dart';
import 'package:scholarsync/themes/palette.dart';
import '../../../widgets/circular_icon_button.dart';

class ProfileInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String degreeProgram;
  final String batch;
  final String studentId;

  const ProfileInfo({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.degreeProgram,
    required this.batch,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      height: 220,
      decoration: BoxDecoration(
        color: CommonColors.primaryGreenColor,
        border: Border.all(
          color: CommonColors.primaryGreenColor,
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
                      iconColor: CommonColors.whiteColor,
                      buttonColor: CommonColors.secondaryGreenColor,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '$firstName $lastName - $studentId',
                  style: const TextStyle(
                    fontSize: 20,
                    color: CommonColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  degreeProgram,
                  style: const TextStyle(
                    color: CommonColors.whiteColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Batch - $batch',
                  style: const TextStyle(
                    color: CommonColors.whiteColor,
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
