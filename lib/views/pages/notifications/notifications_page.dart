import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'widgets/notification_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Notifications',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: false,
          onPressedListButton: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      //body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              NotificationWidget(
                leftIcon: PhosphorIcons.regular.bell,
                text: 'You have upcoming lectures ',
                subtitle: '30 minutes ago',
              ),
              const SizedBox(height: 20),
              NotificationWidget(
                leftIcon: PhosphorIcons.regular.bell,
                text: 'Timetable Updated ',
                subtitle: '40 minutes ago',
              ),
              const SizedBox(height: 20),
              NotificationWidget(
                leftIcon: PhosphorIcons.regular.bell,
                text: 'Timetable Updated',
                subtitle: '40 minutes ago',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
