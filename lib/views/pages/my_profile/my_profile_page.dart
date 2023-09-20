import 'package:flutter/material.dart';
import 'package:scholarsync/views/pages/my_profile/my_projects_page.dart';
import 'package:scholarsync/views/pages/my_profile/widgets/project_box.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'package:scholarsync/views/pages/my_profile/widgets/profile_info.dart';

import '../../../themes/app_theme.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileInfo(),
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
                          builder: (context) => const MyProjectsPage());
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
      ),
    );
  }
}
