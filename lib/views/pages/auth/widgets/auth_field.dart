import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double fontSize;
  final IconData leftIcon;
  final bool? isObsecure;

  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.fontSize,
    required this.leftIcon,
    this.isObsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure!,
      cursorColor: CommonColors.secondaryGreenColor,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CommonColors.secondaryGreenColor)),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: fontSize,
        ),
        prefixIcon: Icon(
          leftIcon,
          color: CommonColors.secondaryGreenColor,
          size: 25,
        ),
      ),
    );
  }
}
