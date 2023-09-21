import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/views/pages/home/academic_staff_page.dart';
import 'package:scholarsync/views/pages/home/settings_page.dart';
import 'package:scholarsync/model/student.dart';
import '../../controllers/student_service.dart';
import '../../themes/palette.dart';

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
  Future<Student?> _fetchUser() async {
    final userData = await StudentService.fetchUserData();
    return userData;
  }

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: Column(
          children: <Widget>[
            buildHeader(context),
            const SizedBox(height: 20),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FutureBuilder(
              future: _fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final student = snapshot.data!;
                  return CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(student.profileImageUrl!),
                  );
                } else {
                  return const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                  );
                }
              },
            ),
            const SizedBox(width: 10),
            FutureBuilder(
              future: _fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final student = snapshot.data!;
                  return Text(
                    '${student.firstName}\n${student.lastName}',
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                } else {
                  return Text(
                    'loading...',
                    style: Theme.of(context).textTheme.displaySmall,
                  );
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          _userName,
          style: const TextStyle(
            color: CommonColors.primaryGreenColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: Icon(
              PhosphorIcons.light.gear,
              size: 25,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            title: Text(
              'Academic Staff',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: Icon(
              PhosphorIcons.light.chalkboardTeacher,
              size: 25,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AcademicStaffPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            title: Text(
              'Give Feedback',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: Icon(
              PhosphorIcons.light.chatCircleDots,
              size: 25,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: Icon(
              PhosphorIcons.light.signOut,
              size: 25,
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
