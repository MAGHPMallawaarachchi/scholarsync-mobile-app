import 'package:flutter/material.dart';
import 'package:scholarsync/themes/app_theme.dart';
import 'package:scholarsync/views/pages/home/home_page.dart';
import 'constants/icon_constants.dart';
import 'themes/palette.dart';
import 'views/pages/calendar/calendar_page.dart';
import 'views/pages/my_profile/my_profile_page.dart';
import 'views/pages/notifications/notifications_page.dart';
import 'views/widgets/drawer_menu.dart';
import 'views/widgets/nav_add.dart';
import 'views/widgets/nav_item.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final tabs = [
    const Center(child: HomePage()),
    const Center(child: CalendarPage()),
    Container(),
    const Center(child: NotificationsPage()),
    const Center(child: MyProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScholarSync',
      theme: AppThemeLight.theme,
      home: Scaffold(
        body: tabs[_selectedIndex],
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 75,
          decoration: const BoxDecoration(
            color: PaletteLightMode.primaryGreenColor,
            boxShadow: [
              BoxShadow(
                color: PaletteLightMode.shadowColor,
                offset: Offset(8, 8),
                blurRadius: 24,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, IconConstants.homeIcon),
                _buildNavItem(1, IconConstants.calendarIcon),
                NavigationAddItem(
                  isSelected: _selectedIndex == 2,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
                _buildNavItem(3, IconConstants.bellFilledIcon),
                _buildNavItem(4, IconConstants.personIcon),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconName) {
    final isSelected = _selectedIndex == index;

    return NavigationItem(
      isSelected: isSelected,
      iconName: iconName,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
