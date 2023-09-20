import 'package:flutter/material.dart';

class ImageRow extends StatelessWidget {
  final double containerSize;
  final bool isCircle;
  final List<String> imagePathList;
  final List<String>? textList;

  const ImageRow({
    super.key,
    required this.containerSize,
    required this.isCircle,
    required this.imagePathList,
    this.textList,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          imagePathList.length,
          (index) => _buildImageContainer(imagePathList[index], containerSize,
              textList != null ? textList![index] : null),
        ),
      ),
    );
  }

  Widget _buildImageContainer(
      String imagePath, double containerWidth, String? textString) {
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
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
