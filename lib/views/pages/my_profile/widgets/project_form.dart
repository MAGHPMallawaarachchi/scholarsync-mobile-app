import 'package:flutter/material.dart';

import '../../../widgets/text_form_field.dart';

class ProjectForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController dateController;
  final TextEditingController linkController;
  final bool isEditing;

  const ProjectForm({
    super.key,
    required this.nameController,
    required this.dateController,
    required this.linkController,
    this.isEditing = false,
  });

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        ReusableTextField(
          controller: widget.nameController,
          labelText: 'Project Name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          onSaved: (value) {},
        ),
        ReusableTextField(
          controller: widget.dateController,
          labelText: 'Date',
          isDateField: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a date';
            }
            return null;
          },
          onSaved: (value) {},
        ),
        ReusableTextField(
          controller: widget.linkController,
          labelText: 'Github Link',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the GitHub link';
            }

            final Uri uri = Uri.parse(value);
            if (uri.scheme.isEmpty || uri.host.isEmpty) {
              return 'Please enter a valid URL';
            }
            return null;
          },
          onSaved: (value) {},
        ),
      ],
    );
  }
}
