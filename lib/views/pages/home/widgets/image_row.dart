import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';

class ImageRow extends StatelessWidget {
  final double containerSize;
  final bool isCircle;
  final Stream<List<String>> imageStream;

  const ImageRow({
    super.key,
    required this.containerSize,
    required this.isCircle,
    required this.imageStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
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
          // Use the updated image URLs
          final imagePathList = snapshot.data!;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Set alignment to start
              children: List.generate(
                imagePathList.length,
                (index) => _buildImageContainer(
                  imagePathList[index],
                  containerSize,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildImageContainer(String imagePath, double containerWidth) {
    return Column(
      children: [
        Container(
          width: containerWidth,
          height: containerWidth,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: ClipRRect(
            borderRadius: isCircle
                ? BorderRadius.circular(containerWidth / 2)
                : BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
