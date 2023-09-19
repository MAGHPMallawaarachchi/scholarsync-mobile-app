import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';

import 'widgets/notification_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Notifications',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: false,
        ),
      ),
      //body
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "inter",
                    color: PaletteLightMode.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                // Notification 01
                Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CommonColors.shadowColor,
                          offset: Offset(8, 8),
                          blurRadius: 24,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: NotificationWidget(
                        leftIcon: PhosphorIcons.regular.bell,
                        text: 'There are upcoming lectures',
                        subtitle: '30 minutes ago',
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
