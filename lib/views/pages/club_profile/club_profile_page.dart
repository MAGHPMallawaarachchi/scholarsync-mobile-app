import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/controllers/club_service.dart';
import 'package:scholarsync/controllers/firebase_auth.dart';
import 'package:scholarsync/model/club.dart';
import 'package:scholarsync/themes/palette.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/circular_icon_button.dart';
import '../../widgets/custom_carousel.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/reusable_form_dialog.dart';
import '../../widgets/text_form_field.dart';
import 'widgets/club_text_container.dart';

class ClubProfilePage extends StatefulWidget {
  const ClubProfilePage({Key? key}) : super(key: key);

  @override
  State<ClubProfilePage> createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends State<ClubProfilePage> {
  final AuthService authService = AuthService();
  final ClubService clubService = ClubService();

  bool isOwner = false;

  Future<bool> checkUserIsClub() async {
    final bool isUserClub = await authService.checkIfUserIsClub();
    setState(() {
      isOwner = isUserClub;
    });
    return isUserClub;
  }

  Future<Club?> _fetchClub() async {
    final clubData = await clubService.getClubByEmail();
    return clubData;
  }

  @override
  void initState() {
    super.initState();
    checkUserIsClub();
    clubService.listenForClubUpdatesByEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Club Profile',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: false,
          onPressedListButton: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<Club?>(
          future: _fetchClub(),
          builder: (context, clubSnapshot) {
            if (clubSnapshot.connectionState == ConnectionState.done) {
              final club = clubSnapshot.data;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildImageBannerWithCircularImage(),
                      Text(
                        club?.name ?? 'Club Name',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(height: 11),
                      if (isOwner)
                        CustomElevatedButton(
                          label: 'Edit Profile',
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          textSize: 10,
                          onPressed: () {
                            _showFormDialog(context, club!);
                          },
                          height: 20,
                          backgroundColor: CommonColors.secondaryGreenColor,
                        ),
                      const SizedBox(height: 20),
                      CustomTextContainer(
                        heading: 'About',
                        text: club?.about ?? 'About Club',
                        headingSize: 16.0,
                        backgroundColor:
                            Theme.of(context).dialogBackgroundColor,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextContainer(
                              heading: 'In Charge',
                              headingSize: 12.0,
                              text: club?.inCharge ?? 'Master/Mistress Name',
                              backgroundColor:
                                  Theme.of(context).dialogBackgroundColor,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomTextContainer(
                              heading: 'President',
                              headingSize: 12.0,
                              text: club?.president ?? 'President Name',
                              backgroundColor:
                                  Theme.of(context).dialogBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upcoming Events by ${club?.name ?? 'Club Name'}',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(height: 15),

                      //carousel
                      CustomCarousel(
                          imageList: club?.events
                                  ?.map<String>(
                                      (event) => event['imageUrl'] as String)
                                  .toList() ??
                              []),
                    ],
                  ),
                ),
              );
            } else if (clubSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(
                child: Text('Club data not available.'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildImageBannerWithCircularImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 370,
        height: 200,
        child: Stack(
          children: [
            _buildImageBannerWithCircularIconButton(),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildCircularImage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBannerWithCircularIconButton() {
    return Stack(
      children: [
        _buildImageBanner(),
        if (isOwner)
          Positioned(
            bottom: 10,
            right: 10,
            child: CircularIconButton(
              buttonSize: 20,
              iconAsset: IconConstants.cameraIcon,
              iconColor: CommonColors.whiteColor,
              buttonColor: CommonColors.secondaryGreenColor,
              onPressed: () {
                clubService.uploadBannerImage();
                setState(() {});
              },
            ),
          ),
      ],
    );
  }

  Widget _buildImageBanner() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FutureBuilder(
          future: _fetchClub(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final club = snapshot.data!;
              return Image.network(
                club.bannerImageURL ?? '',
                fit: BoxFit.cover,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: CommonColors.secondaryGreenColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCircularImage() {
    const imageSize = 75.0;
    const buttonSize = 20.0;

    return Stack(
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: FutureBuilder(
            future: _fetchClub(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final club = snapshot.data!;
                return CircleAvatar(
                  backgroundImage: NetworkImage(club.profileImageURL),
                  radius: imageSize / 2,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.secondaryGreenColor,
                  ),
                );
              }
            },
          ),
        ),
        if (isOwner)
          Positioned(
            bottom: -(buttonSize / 1000),
            right: -(buttonSize / 1000),
            child: CircularIconButton(
              buttonSize: buttonSize,
              iconAsset: IconConstants.cameraIcon,
              iconColor: CommonColors.whiteColor,
              buttonColor: CommonColors.secondaryGreenColor,
              onPressed: () {
                clubService.uploadProfileImage();
                setState(() {});
              },
            ),
          ),
      ],
    );
  }

  void _showFormDialog(BuildContext context, Club club) {
    TextEditingController aboutController =
        TextEditingController(text: club.about);
    TextEditingController inChargeController =
        TextEditingController(text: club.inCharge);
    TextEditingController presidentController =
        TextEditingController(text: club.president);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReusableFormDialog(
          title: 'Edit Profile',
          buttonLabel: 'Save',
          formFields: [
            ReusableTextField(
              controller: aboutController,
              labelText: 'About',
              isMultiline: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please tell us about the club';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            ReusableTextField(
              controller: inChargeController,
              labelText: 'Master/Mistress in Charge',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please add master/mistress in charge';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            ReusableTextField(
              controller: presidentController,
              labelText: 'President',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the name of the president';
                }
                return null;
              },
              onSaved: (value) {},
            ),
          ],
          onSubmit: (formData) async {
            // print(club.id);

            // Update the club properties
            club.about = aboutController.text;
            club.inCharge = inChargeController.text;
            club.president = presidentController.text;

            // Update the club in the repository
            try {
              await clubService.updateClub(club);
            } catch (e) {
              log(e.toString() as num);
            }

            aboutController.dispose();
            inChargeController.dispose();
            presidentController.dispose();
          },
        );
      },
    );
  }
}
