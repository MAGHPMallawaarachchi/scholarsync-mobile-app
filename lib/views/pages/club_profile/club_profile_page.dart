import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
  final String email;
  final bool isTitleCenter;
  const ClubProfilePage(
      {Key? key, required this.email, this.isTitleCenter = false})
      : super(key: key);

  @override
  State<ClubProfilePage> createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends State<ClubProfilePage> {
  final AuthService authService = AuthService();
  final ClubService clubService = ClubService();

  final aboutController = TextEditingController();
  final inChargeController = TextEditingController();
  final presidentController = TextEditingController();

  final User user = FirebaseAuth.instance.currentUser!;

  bool isOwner = false;

  Future<void> checkUserIsClub() async {
    final bool isUserClub = await authService.checkIfUserIsClub();
    if (isUserClub && widget.email == user.email) {
      setState(() {
        isOwner = true;
      });
    }
  }

  Future<void> _refreshClubData() async {
    await Future.delayed(const Duration(seconds: 1));
    await clubService.getClubByEmail(widget.email);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkUserIsClub();
    clubService.getClubByEmail(widget.email);
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
          titleCenter: widget.isTitleCenter,
          leftIcon: widget.isTitleCenter,
          onPressedListButton: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: RefreshIndicator(
        color: CommonColors.secondaryGreenColor,
        onRefresh: _refreshClubData,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<Club?>(
            future: clubService.getClubByEmail(widget.email),
            builder: (context, clubSnapshot) {
              if (clubSnapshot.connectionState == ConnectionState.done) {
                final club = clubSnapshot.data;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildBannerImageWithCircularImage(club!),
                        Text(
                          club.name,
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
                              _showFormDialog(context, club);
                            },
                            height: 20,
                            backgroundColor: CommonColors.secondaryGreenColor,
                          ),
                        const SizedBox(height: 20),
                        CustomTextContainer(
                          heading: 'About',
                          text: club.about ?? 'About Club',
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
                                text: club.inCharge ?? 'Master/Mistress Name',
                                backgroundColor:
                                    Theme.of(context).dialogBackgroundColor,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: CustomTextContainer(
                                heading: 'President',
                                headingSize: 12.0,
                                text: club.president ?? 'President Name',
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
                            'Upcoming Events by ${club.name}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        const SizedBox(height: 15),

                        //carousel
                        CustomCarousel(
                          imageList: club.events
                                  ?.map<String>(
                                      (event) => event['imageUrl'] as String)
                                  .toList() ??
                              [],
                          showIconButton: isOwner,
                          enableAutoScroll: !isOwner,
                          onPressedDeleteButton: (eventIndex, imageUrl) {
                            clubService.deleteEvent(eventIndex, widget.email);
                            setState(() {});
                          },
                        ),
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
      ),
    );
  }

  Widget _buildBannerImageWithCircularImage(Club club) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 370,
        height: 200,
        child: Stack(
          children: [
            _buildBannerImageWithCircularIconButton(club),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildProfileImage(club),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerImageWithCircularIconButton(Club club) {
    return Stack(
      children: [
        _buildBannerImage(club),
        if (isOwner)
          Positioned(
            bottom: 10,
            right: 10,
            child: CircularIconButton(
              buttonSize: 20,
              iconAsset: PhosphorIcons.light.camera,
              iconColor: CommonColors.whiteColor,
              buttonColor: CommonColors.secondaryGreenColor,
              onPressed: () {
                clubService.uploadImageAndUpdateClub('bannerImageURL', club);
                setState(() {});
              },
            ),
          ),
      ],
    );
  }

  Widget _buildBannerImage(Club club) {
    final bannerImageURL = club.bannerImageURL ??
        'https://w7.pngwing.com/pngs/869/370/png-transparent-low-polygon-background-green-banner-low-poly-materialized-flat-thumbnail.png';

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          bannerImageURL,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage(Club club) {
    const imageSize = 75.0;
    const buttonSize = 20.0;

    final profileImageURL = club.profileImageURL;

    return Stack(
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(profileImageURL),
            radius: imageSize / 2,
          ),
        ),
        if (isOwner)
          Positioned(
            bottom: -(buttonSize / 1000),
            right: -(buttonSize / 1000),
            child: CircularIconButton(
              buttonSize: buttonSize,
              iconAsset: PhosphorIcons.light.camera,
              iconColor: CommonColors.whiteColor,
              buttonColor: CommonColors.secondaryGreenColor,
              onPressed: () async {
                await clubService.uploadImageAndUpdateClub(
                    'profileImageURL', club);
                setState(() {});
              },
            ),
          ),
      ],
    );
  }

  void _showFormDialog(BuildContext context, Club club) {
    aboutController.text = club.about ?? '';
    inChargeController.text = club.inCharge ?? '';
    presidentController.text = club.president ?? '';

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
            club.about = aboutController.text;
            club.inCharge = inChargeController.text;
            club.president = presidentController.text;

            await clubService.updateClub(club);
            setState(() {});
          },
        );
      },
    );
  }
}
