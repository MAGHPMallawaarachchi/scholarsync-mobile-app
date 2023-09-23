import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/controllers/student_service.dart';
import 'package:scholarsync/model/student.dart';
import 'package:scholarsync/themes/palette.dart';
import '../../../widgets/circular_icon_button.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final StudentService studentService = StudentService();

  @override
  void initState() {
    super.initState();
    studentService.fetchStudentData();
    setState(() {});
  }

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
      child: FutureBuilder<Student?>(
          future: studentService.fetchStudentData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CommonColors.secondaryGreenColor,
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            } else if (snapshot.hasData) {
              final student = snapshot.data!;
              return Column(
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
                            backgroundImage:
                                NetworkImage(student.profileImageUrl!),
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
                          onPressed: () async {
                            await studentService.uploadProfileImage(student);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${student.firstName} ${student.lastName} - ${student.studentId}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: CommonColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    student.degreeProgram,
                    style: const TextStyle(
                      color: CommonColors.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Batch - ${student.batch}',
                    style: const TextStyle(
                      color: CommonColors.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No data'));
            }
          }),
    );
  }
}
