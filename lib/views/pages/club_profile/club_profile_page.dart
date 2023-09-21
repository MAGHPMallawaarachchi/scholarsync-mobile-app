import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholarsync/controllers/club_service.dart';
import 'package:scholarsync/views/widgets/carousel.dart';
import 'package:scholarsync/views/widgets/circular_icon_button.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'package:scholarsync/constants/image_constants.dart';
import 'package:scholarsync/themes/palette.dart';
import '../../../model/club.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/reusable_form_dialog.dart';
import '../../widgets/text_form_field.dart';
import 'widgets/club_text_container.dart';

class ClubProfilePage extends StatefulWidget {
  const ClubProfilePage({Key? key}) : super(key: key);

  @override
  State<ClubProfilePage> createState() => _ClubProfilePageState();
}

final ClubService clubService = ClubService();
final user = FirebaseAuth.instance.currentUser;

class _ClubProfilePageState extends State<ClubProfilePage> {
  bool isOwner = false;
  String id = '';
  String clubName = '';
  String about = '';
  String masterInCharge = '';
  String president = '';
  String profileImageURL =
      'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg';
  String bannerImageURL =
      'https://w7.pngwing.com/pngs/869/370/png-transparent-low-polygon-background-green-banner-low-poly-materialized-flat-thumbnail.png';
  List<String> eventImages = [];

  void checkUserIsClub() async {
    final bool isUserClub = await clubService.checkIfUserIsClub(user!.uid);
    setState(() {
      isOwner = isUserClub;
    });
  }

  void getClubData() async {
    final Club club = await clubService.getClubById(user!.uid);
    setState(() {
      id = club.id!;
      clubName = club.name!;
      about = club.about!;
      masterInCharge = club.inCharge!;
      president = club.president!;
      profileImageURL = club.profileImageURL!;
      bannerImageURL = club.bannerImageURL!;
      eventImages = club.events
              ?.map<String>((event) => event['imageUrl'] as String)
              .toList() ??
          [];
    });
  }

  Future<void> _uploadImage(
    File imageFile,
    void Function(String) updateImageUrlCallback,
    String imageUrlField,
  ) async {
    final Club club = await clubService.getClubById(user!.uid);
    String storagePath = '';

    if (imageUrlField == profileImageURL) {
      storagePath = 'clubs/${club.name}/profileImage';
    } else if (imageUrlField == bannerImageURL) {
      storagePath = 'clubs/${club.name}/bannerImage';
    }

    final String imageURL =
        await clubService.uploadImage(imageFile, storagePath);

    // Update the image URL field using the callback function
    updateImageUrlCallback(imageURL);

    // Update the club in the repository
    if (imageUrlField == club.profileImageURL) {
      club.profileImageURL = imageURL;
    } else if (imageUrlField == club.bannerImageURL) {
      club.bannerImageURL = imageURL;
    }
    await clubService.updateClub(club);
  }

  Future<void> _updateImage(String imageURLField) async {
    final File? imageFile = await clubService.pickImage();
    if (imageFile != null) {
      await _uploadImage(imageFile, (newImageUrl) {
        setState(() {
          if (imageURLField == profileImageURL) {
            profileImageURL = newImageUrl;
          } else if (imageURLField == bannerImageURL) {
            bannerImageURL = newImageUrl;
          }
        });
      }, imageURLField);
    }
  }

  @override
  void initState() {
    checkUserIsClub();
    getClubData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: clubName,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: false,
          onPressedListButton: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: FutureBuilder<Club>(
        future: clubService.getClubById(user!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading
            return const Center(
              child: CircularProgressIndicator(
                color: CommonColors.secondaryGreenColor,
              ),
            );
          } else if (snapshot.hasError) {
            // If there's an error
            return Text('Error: ${snapshot.error}');
          } else {
            // If data is loaded successfully
            final club = snapshot.data;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildImageBannerWithCircularImage(),
                    Text(
                      club!.name!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: PaletteLightMode.textColor,
                      ),
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
                      text: about,
                      headingSize: 16.0,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextContainer(
                            heading: 'In Charge',
                            headingSize: 12.0,
                            text: masterInCharge,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CustomTextContainer(
                            heading: 'President',
                            headingSize: 12.0,
                            text: president,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: eventImages.isNotEmpty
                          ? Text(
                              'Upcoming Events by $clubName',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: PaletteLightMode.textColor,
                              ),
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(height: 15),
                    eventImages.isNotEmpty
                        ? Carousel(
                            imageList: eventImages,
                            autoScrolling: isOwner ? false : true,
                            showIconButton: isOwner ? true : false,
                            onPressedDeleteButton:
                                (int index, String imageUrl) {
                              if (index >= 0 && index < eventImages.length) {
                                setState(() {
                                  eventImages.removeAt(index);
                                });

                                clubService.deleteEventImage(user!.uid, index);
                              }
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          }
        },
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
                _updateImage("bannerImageURL");
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
        child: Image.network(
          bannerImageURL,
          fit: BoxFit.cover,
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
          child: Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(profileImageURL),
              radius: imageSize / 2,
            ),
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
                _updateImage("profileImageURL");
              },
            ),
          ),
      ],
    );
  }
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
            // print(club.id);
          }

          aboutController.dispose();
          inChargeController.dispose();
          presidentController.dispose();
        },
      );
    },
  );
}
