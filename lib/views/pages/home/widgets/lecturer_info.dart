import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';

class LecturerInformation extends StatelessWidget {
  final String name;
  final String email;
  final String photoAsset;

  const LecturerInformation({
    super.key,
    required this.name,
    required this.email,
    required this.photoAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      decoration: BoxDecoration(
        color:  Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: CommonColors.shadowColor,
            offset: Offset(2, 4),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                //have to add the image
                image: AssetImage(photoAsset),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                style:
                   Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 6.0),
              Text(
                email,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
