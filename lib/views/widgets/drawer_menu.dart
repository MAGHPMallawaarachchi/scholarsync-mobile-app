import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/controllers/firebase_auth.dart';
import 'package:scholarsync/views/pages/home/academic_staff_page.dart';
import 'package:scholarsync/views/pages/home/settings_page.dart';
import 'package:scholarsync/model/student.dart';
import '../../controllers/club_service.dart';
import '../../controllers/student_service.dart';
import '../../model/club.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final StudentService studentService = StudentService();
  final ClubService clubService = ClubService();
  final AuthService authService = AuthService();

  Future<Student?> _fetchUserAsStudent() async {
    final userData = await studentService.fetchStudentData();
    return userData;
  }

  Future<Club?> _fetchUserAsClub() async {
    final clubData = await clubService.fetchClubData();
    print(clubData?.profileImageURL);
    return clubData;
  }

  @override
  void initState() {
    super.initState();
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
              future: authService.checkIfUserIsClub(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == true) {
                    // User is a club owner
                    return FutureBuilder<Club?>(
                      future: _fetchUserAsClub(), // Fetch club data
                      builder: (context, clubSnapshot) {
                        if (clubSnapshot.connectionState ==
                            ConnectionState.done) {
                          final club = clubSnapshot.data;
                          return CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(club?.profileImageURL ?? ''),
                          );
                        } else {
                          return const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                          );
                        }
                      },
                    );
                  } else {
                    // User is a student
                    return FutureBuilder<Student?>(
                      future: _fetchUserAsStudent(), // Fetch student data
                      builder: (context, studentSnapshot) {
                        if (studentSnapshot.connectionState ==
                            ConnectionState.done) {
                          final student = studentSnapshot.data;
                          return CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(student
                                    ?.profileImageUrl ??
                                'https://example.com/default-student-image.jpg'),
                          );
                        } else {
                          return const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                          );
                        }
                      },
                    );
                  }
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
              future: authService.checkIfUserIsClub(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == true) {
                    // User is a club owner
                    return FutureBuilder<Club?>(
                      future: _fetchUserAsClub(), // Fetch club data
                      builder: (context, clubSnapshot) {
                        if (clubSnapshot.connectionState ==
                            ConnectionState.done) {
                          final club = clubSnapshot.data;
                          return Text(
                            club?.name ?? 'Club Owner',
                            style: Theme.of(context).textTheme.displayLarge,
                          );
                        } else {
                          return Text(
                            'loading...',
                            style: Theme.of(context).textTheme.displaySmall,
                          );
                        }
                      },
                    );
                  } else {
                    // User is a student
                    return FutureBuilder<Student?>(
                      future: _fetchUserAsStudent(), // Fetch student data
                      builder: (context, studentSnapshot) {
                        if (studentSnapshot.connectionState ==
                            ConnectionState.done) {
                          final student = studentSnapshot.data;
                          return Text(
                            student?.firstName ?? 'Student',
                            style: Theme.of(context).textTheme.displayLarge,
                          );
                        } else {
                          return Text(
                            'loading...',
                            style: Theme.of(context).textTheme.displaySmall,
                          );
                        }
                      },
                    );
                  }
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
