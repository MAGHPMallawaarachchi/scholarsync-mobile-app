import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:scholarsync/views/widgets/search_bar.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/constants/image_constants.dart';
import '../../widgets/custom_carousel.dart';
import '../../widgets/text_container.dart';
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
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'Hi, ATD Gamage',
                style: TextStyle(
                  color: PaletteLightMode.titleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  IconConstants.graduationHatIcon,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    PaletteLightMode.secondaryGreenColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'NSBM Green University',
                  style: TextStyle(
                    color: PaletteLightMode.secondaryGreenColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        titleTextStyle: const TextStyle(
          color: PaletteLightMode.titleColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              IconConstants.hamburgerMenuIcon,
              colorFilter: const ColorFilter.mode(
                PaletteLightMode.secondaryGreenColor,
                BlendMode.srcIn,
              ),
              width: 40,
              height: 40,
            ),
            tooltip: 'Menu',
            onPressed: () {
              //Open the Sidebar
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

              //text
              TextContainer(
                  fontText: 'Kuppi Sessions',
                  secondText: 'view all',
                  onTap: () {
                    return context.go('/kuppi');
                  }),
              const SizedBox(
                height: 5,
              ),

              //imageRow
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
              const SizedBox(
                height: 10,
              ),

              //text
              TextContainer(
                fontText: 'Clubs & Organizations',
                secondText: 'view all',
                onTap: () {
                  //onTap funtion for the text
                },
              ),
              const SizedBox(
                height: 5,
              ),

              //imageRow
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
                textList: const [
                  'Hello1',
                  'NSBM',
                  'hello',
                  'reddathama',
                  'redda',
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
