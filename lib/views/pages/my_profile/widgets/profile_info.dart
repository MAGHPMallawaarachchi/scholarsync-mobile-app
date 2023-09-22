import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/controllers/student_service.dart';
import 'package:scholarsync/themes/palette.dart';
import '../../../widgets/circular_icon_button.dart';

class ProfileInfo extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String degreeProgram;
  final String batch;
  final String studentId;
  final String profileImageUrl;
  final String id;

  const ProfileInfo({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.degreeProgram,
    required this.batch,
    required this.studentId,
    required this.profileImageUrl,
    required this.id,
  });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final StudentService studentService = StudentService();

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.profileImageUrl),
                    radius: 90 / 2,
                  ),
                ),
              ),
              Positioned(
                bottom: -(20 / 1000),
                right: -(20 / 1000),
                child: CircularIconButton(
                  buttonSize: 20,
                  iconAsset: IconConstants.cameraIcon,
                  iconColor: CommonColors.whiteColor,
                  buttonColor: CommonColors.secondaryGreenColor,
                  onPressed: () {
                    studentService.updateProfileImageURL(
                        widget.id, widget.studentId);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${widget.firstName} ${widget.lastName} - ${widget.studentId}',
            style: const TextStyle(
              fontSize: 20,
              color: CommonColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.degreeProgram,
            style: const TextStyle(
              color: CommonColors.whiteColor,
              fontSize: 14,
            ),
          ),
          Text(
            'Batch - ${widget.batch}',
            style: const TextStyle(
              color: CommonColors.whiteColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
