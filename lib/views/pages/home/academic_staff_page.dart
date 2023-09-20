import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'package:scholarsync/views/pages/home/home_page.dart';
import 'package:scholarsync/views/pages/home/widgets/academic_staff_page_tab.dart';
import 'package:scholarsync/views/pages/home/widgets/lecturer_info.dart';

class AcademicStaffPage extends StatefulWidget {
  const AcademicStaffPage({super.key});

  @override
  State<AcademicStaffPage> createState() => _AcademicStaffPageState();
}

class _AcademicStaffPageState extends State<AcademicStaffPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Academic Staff',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: false,
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
                ListView(
                  children: const [
                    LecturerInformation(
                      name: 'Mrs. Sophia Williams',
                      email: 'sophiawilliams@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer1.jpg',
                    ),
                    LecturerInformation(
                      name: 'Mrs. Olivia Johnson',
                      email: 'oliviajohnson@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer2.jpg',
                    ),
                    LecturerInformation(
                      name: 'Mr. Liam Smith',
                      email: 'liamsmith@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer1.jpg',
                    ),
                    // Add more lecturer information boxes for department 1
                  ],
                ),
                ListView(
                  children: const [
                    LecturerInformation(
                      name: 'Mr. Roland Stern',
                      email: 'rolandstern@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer3.jpg',
                    ),
                    LecturerInformation(
                      name: 'Mr. Jackson Wang',
                      email: 'jacksonwang@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer4.jpg',
                    ),
                    LecturerInformation(
                      name: 'Mrs. Stephanie Hartley',
                      email: 'stephaniehartley@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer1.jpg',
                    ),
                    // Add more lecturer information boxes for department 2
                  ],
                ),
                ListView(
                  children: const [
                    LecturerInformation(
                      name: 'Mrs. Nancy Wheeler',
                      email: 'nancywheeler@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer5.jpg',
                    ),
                    LecturerInformation(
                      name: 'Mrs. Joyce Byers',
                      email: 'joycebyers@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer6.jpg',
                    ),
                    LecturerInformation(
                      name: 'Mr. Dustin Henderson',
                      email: 'dustinhenderson@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer1.jpg',
                    ),
                    // Add more lecturer information boxes for department 3
                  ],
                ),
                ListView(
                  children: const [
                    LecturerInformation(
                      name: 'Mrs. Monet Addams',
                      email: 'monetaddams@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer7.jpg',
                    ),
                    LecturerInformation(
                      name: 'Mr. Lucas Sinclair',
                      email: 'lucassinclair@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer8.jpg',
                    ),
                    LecturerInformation(
                      name: 'Mrs. Naomi Watson',
                      email: 'naomiwatson@gmail.com',
                      //have to add the images
                      photoAsset: 'assets/lecturer1.jpg',
                    ),
                    // Add more lecturer information boxes for department 4
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
