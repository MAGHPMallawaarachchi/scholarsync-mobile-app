import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/views/widgets/circular_icon_button.dart';
import 'dart:async';
import 'package:scholarsync/themes/palette.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> imageList;
  final double containerPadding;
  final bool showIconButton;
  final bool enableAutoScroll;
  final Function(int eventIndex, String imageUrl)? onPressedDeleteButton;
  final int autoScrollDuration;

  const CustomCarousel({
    Key? key,
    required this.imageList,
    this.containerPadding = 20.0,
    this.showIconButton = false,
    this.enableAutoScroll = true,
    this.onPressedDeleteButton,
    this.autoScrollDuration = 3,
  }) : super(key: key);

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late PageController _pageController;
  Timer? _autoScrollTimer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
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
        if (currentPage == widget.imageList.length - 1) {
          currentPage = 0;
          _pageController.animateToPage(
            0,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        } else {
          currentPage++;
          _pageController.nextPage(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        }
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
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentPage =
                      index; // Update currentPage when the page changes
                });
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
                            iconAsset: PhosphorIcons.light.trash,
                            iconColor: CommonColors.whiteColor,
                            buttonColor: CommonColors.primaryRedColor,
                            onPressed: () {
                              if (widget.onPressedDeleteButton != null) {
                                widget.onPressedDeleteButton!(
                                  currentPage, // Use currentPage
                                  widget.imageList[
                                      currentPage], // Use currentPage
                                );
                              }
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
                  color: currentPage == index // Use currentPage
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
