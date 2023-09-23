import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/views/widgets/custom_elevated_button.dart';
import 'package:scholarsync/themes/palette.dart';

import 'circular_icon_button.dart';

class ReusableFormDialog extends StatefulWidget {
  final String title;
  final List<Widget> formFields;
  final void Function(Map<String, String> formData)? onSubmit;
  final String buttonLabel;
  final void Function()? onPop;

  const ReusableFormDialog({
    Key? key,
    required this.title,
    required this.buttonLabel,
    required this.formFields,
    this.onSubmit,
    this.onPop,
  }) : super(key: key);

  @override
  State<ReusableFormDialog> createState() => _ReusableFormDialogState();
}

class _ReusableFormDialogState extends State<ReusableFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircularIconButton(
                  buttonSize: 30,
                  iconAsset: IconConstants.closeIcon,
                  iconColor: CommonColors.secondaryGreenColor,
                  buttonColor: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.formFields,
              const SizedBox(height: 10),
              CustomElevatedButton(
                label: widget.buttonLabel,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (widget.onSubmit != null) {
                      widget.onSubmit!(_formData);
                    }

                    Navigator.pop(context);
                  }
                },
                backgroundColor: CommonColors.secondaryGreenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
