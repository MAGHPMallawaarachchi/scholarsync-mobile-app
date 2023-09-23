import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';

import '../../club_profile/club_profile_page.dart';

class ClubsRow extends StatelessWidget {
  final double containerSize;
  final Stream<List<Map<String, String>>> imageStream;

  const ClubsRow({
    Key? key,
    required this.containerSize,
    required this.imageStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, String>>>(
      stream: imageStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: CommonColors.secondaryGreenColor,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No images available.');
        } else {
          // Use the updated image URLs with email
          final imageList = snapshot.data!;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                imageList.length,
                (index) => _buildImageContainer(
                  imageList[index]['imageUrl']!,
                  containerSize,
                  imageList[index]['email']!,
                  context,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildImageContainer(String imagePath, double containerWidth,
      String email, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(
              builder: (context) =>
                  ClubProfilePage(email: email, isTitleCenter: true),
            );
            Navigator.push(context, route);
          },
          child: Container(
            width: containerWidth,
            height: containerWidth,
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(containerWidth / 2),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
