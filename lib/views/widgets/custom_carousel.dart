import 'package:flutter/material.dart';
import 'package:scholarsync/views/widgets/circular_icon_button.dart';
import 'dart:async';
import 'package:scholarsync/themes/palette.dart';

import '../../constants/icon_constants.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> imageList;
  final double containerPadding;
  final bool showIconButton;
  final bool enableAutoScroll;
  final Function(int eventIndex, String imageUrl)? onPressedDeleteButton;
  final int autoScrollDuration; // Added for customizing auto-scroll duration

  const CustomCarousel({
    Key? key,
    required this.imageList,
    this.containerPadding = 20.0,
    this.showIconButton = false,
    this.enableAutoScroll = true,
    this.onPressedDeleteButton,
    this.autoScrollDuration = 3, // Default auto-scroll duration
  }) : super(key: key);

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late PageController _pageController;
  Timer? _autoScrollTimer;
  int pageNo = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageNo);
    if (widget.enableAutoScroll) {
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(
      Duration(seconds: widget.autoScrollDuration),
      (timer) {
        if (pageNo == widget.imageList.length - 1) {
          pageNo = 0;
        } else {
          pageNo++;
        }
        _pageController.animateToPage(
          pageNo,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width -
                2 * widget.containerPadding, // Square container
            child: PageView.builder(
              key: const Key('customCarouselPageView'), // Added a key
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                pageNo = index;
              },
              itemBuilder: (_, index) {
                return Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.imageList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    if (widget.showIconButton)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularIconButton(
                            buttonSize: 25,
                            iconAsset: IconConstants.deleteIcon,
                            iconColor: CommonColors.whiteColor,
                            buttonColor: CommonColors.primaryRedColor,
                            onPressed: () {
                              widget.onPressedDeleteButton!(
                                pageNo,
                                widget.imageList[pageNo],
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                );
              },
              itemCount: widget.imageList.length,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imageList.length,
              (index) => Container(
                margin: const EdgeInsets.all(5),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: pageNo == index
                      ? CommonColors.secondaryGreenColor
                      : PaletteLightMode.secondaryTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
