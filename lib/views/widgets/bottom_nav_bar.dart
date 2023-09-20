import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/views/widgets/nav_item.dart';

import 'nav_add.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      decoration: const BoxDecoration(
        color: CommonColors.primaryGreenColor,
        boxShadow: [
          BoxShadow(
            color: CommonColors.shadowColor,
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
            _buildNavItem(0, PhosphorIcons.fill.house),
            _buildNavItem(1, PhosphorIcons.fill.calendarBlank),
            NavigationAddItem(
              isSelected: _selectedIndex == 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            _buildNavItem(3, PhosphorIcons.fill.bell),
            _buildNavItem(4, PhosphorIcons.fill.user),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData iconName) {
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
