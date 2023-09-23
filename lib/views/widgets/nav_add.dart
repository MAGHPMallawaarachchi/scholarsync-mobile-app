import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholarsync/controllers/club_service.dart';
import 'package:scholarsync/controllers/student_service.dart';
import '../../constants/icon_constants.dart';
import '../../controllers/firebase_auth.dart';
import '../../model/project.dart';
import '../../themes/palette.dart';
import '../pages/my_profile/widgets/project_form.dart';
import 'reusable_form_dialog.dart';

class NavigationAddItem extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationAddItem({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<NavigationAddItem> createState() => _NavigationAddItemState();
}

class _NavigationAddItemState extends State<NavigationAddItem> {
  final ClubService _clubService = ClubService();
  final StudentService _studentService = StudentService();
  final AuthService _authService = AuthService();
  final User user = FirebaseAuth.instance.currentUser!;
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _linkController = TextEditingController();

  Future<void> _uploadEvent() async {
    bool isClub = await _authService.checkIfUserIsClub();
    if (isClub) {
      await _clubService.uploadEvent(user.email!);
    } else {
      _uploadProject();
    }
  }

  Future<void> createNewProject() async {
    try {
      Project project = Project(
        name: _nameController.text,
        date: DateTime.parse(_dateController.text),
        link: _linkController.text,
      );

      await _studentService.createNewProject(project);
      setState(() {});
    } catch (e) {
      // print(e);
    }
  }

  Future<void> _uploadProject() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReusableFormDialog(
          title: 'Add New Project',
          buttonLabel: 'Add',
          formFields: [
            const SizedBox(height: 15),
            ProjectForm(
              nameController: _nameController,
              dateController: _dateController,
              linkController: _linkController,
            ),
          ],
          onSubmit: (formData) async {
            await createNewProject();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final circleColor = widget.isSelected
        ? CommonColors.secondaryGreenColor
        : CommonColors.whiteColor;
    final iconColor = widget.isSelected
        ? CommonColors.whiteColor
        : CommonColors.primaryGreenColor;
    final lineColor = widget.isSelected
        ? CommonColors.transparentColor
        : CommonColors.transparentColor;

    return Expanded(
      child: InkWell(
        onTap: () {
          _uploadEvent();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  IconConstants.addButtonIcon,
                  colorFilter: ColorFilter.mode(
                    iconColor,
                    BlendMode.srcIn,
                  ),
                  width: 10,
                  height: 10,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
