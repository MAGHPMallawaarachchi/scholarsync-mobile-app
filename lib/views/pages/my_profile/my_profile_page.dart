import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/views/pages/my_profile/my_projects_page.dart';
import 'package:scholarsync/views/pages/my_profile/widgets/project_box.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'package:scholarsync/views/pages/my_profile/widgets/profile_info.dart';

import '../../../controllers/student_controller.dart';
import '../../../model/student.dart';
import '../../../themes/app_theme.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  // Future<Map<String, dynamic>> _fetchUser() async {
  //   final userData = await StudentController.fetchUserData();
  //   return userData;
  // }

  Future<Student?> _fetchUser() async {
    final userData = await StudentController.fetchUserData();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: 'My Profile',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            titleCenter: false,
            onPressedListButton: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        body: FutureBuilder(
            future: _fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: CommonColors.secondaryGreenColor,
                ));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              } else {
                final student = snapshot.data!;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfo(
                        firstName: student.firstName,
                        lastName: student.lastName,
                        degreeProgram: student.degreeProgram,
                        batch: student.batch,
                        studentId: student.studentId,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Projects',
                            style: getTextTheme(context, true).headlineMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => const MyProjectsPage());
                              Navigator.push(context, route);
                            },
                            child: TextButton(
                              onPressed: () {
                                Route route = MaterialPageRoute(
                                    builder: (context) =>
                                        const MyProjectsPage());
                                Navigator.push(context, route);
                              },
                              child: Text(
                                'view all',
                                style: getTextTheme(context, true).displaySmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.all(0),
                              sliver: SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200.0,
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 20.0,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return const ProjectBox(
                                      projectNumber: '1',
                                      projectName: 'Project Name 1',
                                      date: '2023-07-23',
                                      githubLink: 'https://github.com/project1',
                                    );
                                  },
                                  childCount: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
