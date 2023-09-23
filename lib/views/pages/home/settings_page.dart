import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import '../../../sidebar/bloc.navigation_bloc/navigation_bloc.dart';
import 'widgets/settings_widget.dart';

class SettingsPage extends StatelessWidget implements NavigationStates{
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(kToolbarHeight), // Set the preferred height
        child: CustomAppBar(
          title: 'Settings',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: true,
          leftIcon: true,
          onPressedListButton: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      //body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'General',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          //settings widget 01
          SettingsWidget(
            isSwitch: true,
            leftIcon: PhosphorIcons.light.bell,
            text: 'Receive Notifications',
            onToggle: (value) {},
            isSwitched: false,
          ),
          const SizedBox(height: 20),
          Text(
            'Theme',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          SettingsWidget(
            isSwitch: false,
            leftIcon: PhosphorIcons.light.moon,
            text: 'Dark Mode',
            onToggle: (value) {},
            isSwitched: false,
          ),
        ]),
      ),
    );
  }
}
