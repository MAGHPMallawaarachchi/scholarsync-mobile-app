import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';
import '../../../controllers/lecturer_service.dart';
import '../../../model/lecturer.dart';
import '../../widgets/app_bar.dart';
import 'widgets/academic_staff_page_tab.dart';
import 'widgets/lecturer_info.dart';

class AcademicStaffPage extends StatefulWidget {
  const AcademicStaffPage({super.key});

  @override
  State<AcademicStaffPage> createState() => _AcademicStaffPageState();
}

class _AcademicStaffPageState extends State<AcademicStaffPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final LecturerService _lecturerService = LecturerService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(kToolbarHeight), // Set the preferred height
        child: CustomAppBar(
          title: 'Academic Staff',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: true,
          leftIcon: true,
          onPressedListButton: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Column(
        children: [
          AcademicStaffPageTabs(tabController: _tabController),
          const SizedBox(height: 8.0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Add FutureBuilder for the first tab (DS).
                FutureBuilder<List<Lecturer>>(
                  future: _lecturerService.getLecturers('DS'),
                  builder: (context, snapshot) {
                    return buildTabContent(snapshot);
                  },
                ),
                // Add FutureBuilder for the second tab (NS).
                FutureBuilder<List<Lecturer>>(
                  future: _lecturerService.getLecturers('NS'),
                  builder: (context, snapshot) {
                    return buildTabContent(snapshot);
                  },
                ),
                // Add FutureBuilder for the third tab (IS).
                FutureBuilder<List<Lecturer>>(
                  future: _lecturerService.getLecturers('IS'),
                  builder: (context, snapshot) {
                    return buildTabContent(snapshot);
                  },
                ),
                // Add FutureBuilder for the fourth tab (CSSE).
                FutureBuilder<List<Lecturer>>(
                  future: _lecturerService.getLecturers('CSSE'),
                  builder: (context, snapshot) {
                    return buildTabContent(snapshot);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build tab content.
  Widget buildTabContent(AsyncSnapshot<List<Lecturer>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator(
        color: CommonColors.secondaryGreenColor,
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Text('No lecturers found.');
    } else {
      final lecturers = snapshot.data!;
      return ListView.builder(
        itemCount: lecturers.length,
        itemBuilder: (context, index) {
          final lecturer = lecturers[index];
          return LecturerInformation(
            id: lecturer.id,
            name: lecturer.name,
            email: lecturer.email,
            imageUrl: lecturer.profileImageURL,
          );
        },
      );
    }
  }
}
