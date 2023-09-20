import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/themes/palette.dart';

class ProjectBox extends StatelessWidget {
  final String projectNumber;
  final String projectName;
  final String date;
  final String githubLink;

  const ProjectBox({
    Key? key,
    required this.projectNumber,
    required this.projectName,
    required this.date,
    required this.githubLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: CommonColors.shadowColor,
            offset: Offset(8, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(IconConstants.projectManagementIcon),
              Text('Project $projectNumber',
                  style: Theme.of(context).textTheme.displaySmall),
              Icon(PhosphorIcons.fill.dotsThreeOutline),
            ],
          ),
          const SizedBox(height: 20),
          Text(projectName, style: Theme.of(context).textTheme.headlineMedium),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 0.5),
              SizedBox(
                  width: 60,
                  height: 20,
                  child: Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
              const Spacer(),
              Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: CommonColors.secondaryGreenColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Center(
                    child: Text(
                      'GitHub',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: CommonColors.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
