import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:scholarsync/views/widgets/button_icon.dart';
import 'package:scholarsync/views/widgets/search_bar.dart';
import 'package:scholarsync/constants/icon_constants.dart';
import 'package:scholarsync/views/widgets/text_form_field.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'package:scholarsync/views/pages/home/widgets/kuppi_widget.dart';
import 'package:scholarsync/constants/image_constants.dart';
import 'package:scholarsync/views/widgets/reusable_form_dialog.dart';
import 'package:scholarsync/themes/palette.dart';

class KuppiPage extends StatefulWidget {
  const KuppiPage({super.key});

  @override
  State<KuppiPage> createState() => _KuppiPageState();
}

class _KuppiPageState extends State<KuppiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UIConstants.appBar(
          title: 'Kuppi Sessions',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          titleCenter: true,
          leftIcon: IconConstants.leftArrowIcon,
          rightIcon: IconConstants.hamburgerMenuIcon,
          leftIconToolTip: 'Back to login page',
          onLeftIconPressed: () {
            Navigator.pop(context);
          },
          onRightIconPressed: () {},
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomSearchBar(
              hint: 'Search for kuppi sessions...',
              onSearchSubmitted: (query) {},
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                children: const [
                  KuppiWidget(
                    title: 'MICROPYTHON',
                    subtitle: 'by ATD Gamage',
                    date: '30th July, 2023',
                    imagePath: ImageConstants.kuppi1,
                  ),
                  SizedBox(height: 20),
                  KuppiWidget(
                    title: 'Mathematics for Computing',
                    subtitle: 'by ATD Gamage',
                    date: '30th July, 2023',
                    imagePath: ImageConstants.kuppi1,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PaletteLightMode.secondaryGreenColor,
          tooltip: 'Increment',
          onPressed: () {
            _showFormDialog(context);
          },
          child: SvgPicture.asset(
            IconConstants.addButtonIcon,
            colorFilter: const ColorFilter.mode(
              PaletteLightMode.whiteColor,
              BlendMode.srcIn,
            ),
            width: 25,
            height: 25,
          ),
        ));
  }
}

void _showFormDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReusableFormDialog(
        title: 'Add New Kuppi Session',
        buttonLabel: 'Add',
        formFields: [
          const SizedBox(height: 5),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: PaletteLightMode.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: PaletteLightMode.shadowColor,
                      offset: Offset(8, 8),
                      blurRadius: 24,
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
              Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: PaletteLightMode.secondaryTextColor,
                    shape: BoxShape.circle,
                  ),
                  child: ButtonIcon(
                    icon: IconConstants.cameraIcon,
                    iconColor: PaletteLightMode.whiteColor,
                    size: 20,
                    onTap: () {},
                  )),
            ],
          ),
          const SizedBox(height: 15),
          ReusableTextField(
            labelText: 'Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          ReusableTextField(
            labelText: 'Date',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          ReusableTextField(
            labelText: 'Conducted by',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the name of the conductor';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          ReusableTextField(
            labelText: 'Link to join',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the link to join';
              }
              return null;
            },
            onSaved: (value) {},
          ),
        ],
        onSubmit: (formData) {},
      );
    },
  );
}
