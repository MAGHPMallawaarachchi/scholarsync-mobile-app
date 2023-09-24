import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/views/widgets/custom_elevated_button.dart';

class DeleteConfirmationAlert extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final Function onConfirmPressed;

  const DeleteConfirmationAlert({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.onConfirmPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        PhosphorIcons.fill.trash,
        color: CommonColors.errorColor,
        size: 40,
      ),
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      buttonPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.displayMedium,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomElevatedButton(
              height: 40,
              label: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
              backgroundColor: Theme.of(context).dividerColor,
              labelColor: CommonColors.whiteColor,
            ),
            CustomElevatedButton(
              height: 40,
              label: 'Delete',
              onPressed: () {
                onConfirmPressed();
              },
              backgroundColor: CommonColors.errorColor,
              labelColor: CommonColors.whiteColor,
            ),
          ],
        ),
      ],
    );
  }
}
