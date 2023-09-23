import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholarsync/controllers/club_service.dart';
import 'package:scholarsync/controllers/student_service.dart';
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

  Future<void> _upload() async {
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
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CommonColors.whiteColor,
          ),
          child: const Icon(
            Icons.add,
            color: CommonColors.primaryGreenColor,
            size: 55,
          ),
        ),
      ),
      onTap: () {
        _upload();
      },
    );
  }
}
