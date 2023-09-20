import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/views/pages/home/kuppi_page.dart';
import 'package:scholarsync/views/widgets/search_bar.dart';
import 'package:scholarsync/constants/image_constants.dart';
import '../../../themes/app_theme.dart';
import '../../widgets/custom_carousel.dart';
import '../../../themes/palette.dart';
import 'widgets/image_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Hi, ATD Gamage',
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  PhosphorIcons.fill.graduationCap,
                  color: CommonColors.secondaryGreenColor,
                  size: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'NSBM Green University',
                  style: TextStyle(
                    color: CommonColors.secondaryGreenColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              PhosphorIcons.bold.list,
              color: CommonColors.secondaryGreenColor,
              size: 28,
            ),
            tooltip: 'Menu',
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //searchbar
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CustomSearchBar(
                  hint: 'Search for students and clubs...',
                  onSearchSubmitted: (value) {
                    //Search funtion
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              //carousel
              const Center(
                child: CustomCarousel(
                  imageList: [
                    ImageConstants.eventImg1,
                    ImageConstants.eventImg2,
                    ImageConstants.eventImg3,
                    ImageConstants.eventImg4,
                    ImageConstants.eventImg5,
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kuppi Sessions',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => const KuppiPage());
                      Navigator.push(context, route);
                    },
                    child: Text(
                      'view all',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              ImageRow(
                containerSize: MediaQuery.of(context).size.width * 0.4,
                isCircle: false,
                imagePathList: const [
                  ImageConstants.img1,
                  ImageConstants.img1,
                  ImageConstants.img1,
                  ImageConstants.img1,
                ],
              ),

              const SizedBox(height: 30),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clubs & Societies',
                    style: getTextTheme(context, true).headlineMedium,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              ImageRow(
                containerSize: MediaQuery.of(context).size.width * 0.2,
                isCircle: true,
                imagePathList: const [
                  ImageConstants.img1,
                  ImageConstants.img1,
                  ImageConstants.img1,
                  ImageConstants.img1,
                  ImageConstants.img1,
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
