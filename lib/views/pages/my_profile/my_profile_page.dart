import 'package:flutter/material.dart';
import 'package:scholarsync/controllers/student_service.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:scholarsync/utils/format_date.dart';
import 'package:scholarsync/views/pages/my_profile/my_projects_page.dart';
import 'package:scholarsync/views/pages/my_profile/widgets/project_box.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'package:scholarsync/views/pages/my_profile/widgets/profile_info.dart';
import '../../../model/project.dart';
import '../../../themes/app_theme.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final StudentService studentService = StudentService();

  Future<void> _refreshStudentData() async {
    await Future.delayed(const Duration(seconds: 1));
    await studentService.fetchStudentData();
    setState(() {});
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
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
                        builder: (context) => const MyProjectsPage(),
                      );
                      Navigator.push(context, route);
                    },
                    child: Text(
                      'view all',
                      style: getTextTheme(context, true).displaySmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: studentService.fetchProjectsForStudent(),
                builder: (context, projectSnapshot) {
                  if (projectSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: CommonColors.secondaryGreenColor,
                      ),
                    );
                  } else if (projectSnapshot.hasError) {
                    return Center(
                      child: Text('Error${projectSnapshot.error}'),
                    );
                  } else if (projectSnapshot.data != null &&
                      projectSnapshot.data!.isNotEmpty) {
                    final List<Project>? projects = projectSnapshot.data;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.4, // Adjust the height as needed
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
                                  if (index < projects.length) {
                                    final project = projects[index];
                                    return ProjectBox(
                                      projectNumber: (index + 1).toString(),
                                      projectName: project.name,
                                      date: FormatDate.projectformatDate(
                                        DateTime.parse(
                                          project.date.toString(),
                                        ),
                                      ),
                                      githubLink: project.link,
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                                childCount:
                                    projects!.length < 4 ? projects.length : 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('No projects'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
