import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/constants/image_constants.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/views/widgets/custom_elevated_button.dart';

import 'widgets/auth_field.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.loginBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White box
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstants.logo,
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 20),
                    // Email Input
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AuthField(
                        controller: emailController,
                        hintText: 'Enter your email',
                        fontSize: 16,
                        leftIcon: PhosphorIcons.regular.envelope,
                      ),
                    ),
                    // Password Input
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AuthField(
                        isObsecure: true,
                        controller: passwordController,
                        hintText: 'Enter your password',
                        fontSize: 16,
                        leftIcon: PhosphorIcons.regular.lockKey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Remember Me Checkbox
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isChecked
                                    ? CommonColors.secondaryGreenColor
                                    : Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              borderRadius: BorderRadius.circular(
                                  30), // Match the container's shape
                              child: Container(
                                width: 18, // Match the container's size
                                height: 18, // Match the container's size
                                decoration: isChecked
                                    ? const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CommonColors
                                            .secondaryGreenColor, // Fill color when selected
                                      )
                                    : null,
                                child: isChecked
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors
                                            .white, // Icon color when selected
                                        size: 12,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text('Remember me',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Log In Button
                    CustomElevatedButton(label: 'Log In', onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
