import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/views/pages/home/settings_page.dart';
import '../../themes/palette.dart';
import 'button_icon.dart';

class DrawerMenu extends StatefulWidget {
  // final int selectedIndex;
  // final Function(int) onItemTapped;

  const DrawerMenu({
    Key? key,
    // required this.selectedIndex,
    // required this.onItemTapped,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String _userName = ''; // User's name
  String _userImage = ''; // User's image URL

  @override
  void initState() {
    super.initState();
    // Fetch user data here from your database or API
    _fetchUserData().then((userData) {
      setState(() {
        _userName = userData['John Doe']!;
        _userImage = userData['image']!;
      });
    });
  }

  Future<Map<String, String>> _fetchUserData() async {
    await Future.delayed(const Duration(seconds: 5));
    return {
      'name': 'John Doe', // Replace with the user's name
      'image':
          'https://example.com/user-image.jpg', // Replace with the user's image URL
    };
  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width * 0.7;

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        backgroundColor: PaletteLightMode.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: PaletteLightMode.backgroundColor,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: PaletteLightMode.primaryGreenColor,
                    backgroundImage: NetworkImage(_userImage),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _userName,
                    style: const TextStyle(
                      color: PaletteLightMode.primaryGreenColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text(
                'My Profile',
                style: TextStyle(color: PaletteLightMode.titleColor),
              ),
              leading: ButtonIcon(
                icon: IconConstants.personIcon,
                size: 16.0,
                iconColor: PaletteLightMode.primaryGreenColor,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            GestureDetector(
              child: ListTile(
                title: const Text(
                  'Settings',
                  style: TextStyle(color: PaletteLightMode.titleColor),
                ),
                leading: ButtonIcon(
                  icon: IconConstants.settingOutlinedIcon,
                  size: 16.0,
                  backgroundColor: Colors.transparent,
                  iconColor: Colors.black,
                  // isSelected: widget.selectedIndex == 1,
                  onTap: () {},
                ),
              ),
              onTap: () {
                Route route = MaterialPageRoute(
                    builder: (context) => const SettingsPage());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              title: const Text(
                'Academic Staff',
                style: TextStyle(color: PaletteLightMode.titleColor),
              ),
              leading: ButtonIcon(
                icon: IconConstants.teacherIcon,
                size: 16.0,
                backgroundColor: Colors.transparent,
                iconColor: Colors.black,
                // isSelected: widget.selectedIndex == 2,
                onTap: () {
                  // widget.onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text(
                'Give Feedback',
                style: TextStyle(color: PaletteLightMode.titleColor),
              ),
              leading: ButtonIcon(
                icon: IconConstants.personIcon,
                size: 16.0,
                backgroundColor: Colors.transparent,
                iconColor: Colors.black,
                // isSelected: widget.selectedIndex == 0, // Highlight if selected
                onTap: () {
                  // widget.onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(color: PaletteLightMode.titleColor),
              ),
              leading: ButtonIcon(
                icon: IconConstants.personIcon,
                size: 16.0,
                backgroundColor: Colors.transparent,
                iconColor: Colors.black,
                // isSelected: widget.selectedIndex == 0, // Highlight if selected
                onTap: () {
                  // widget.onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
