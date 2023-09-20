import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../themes/palette.dart';

class KuppiWidget extends StatefulWidget {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String link;
  final String date;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const KuppiWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.link,
    required this.date,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _KuppiWidgetState createState() => _KuppiWidgetState();
}

class _KuppiWidgetState extends State<KuppiWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: CommonColors.shadowColor,
            offset: Offset(8, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Image.network(
              widget.imageUrl,
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.title,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Transform.rotate(
                            angle: 1.5708, // 90 degrees in radians
                            child: PopupMenuButton<String>(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'edit',
                                  onTap: widget.onEdit,
                                  child: const Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  onTap: widget.onDelete,
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: CommonColors.secondaryGreenColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await launchUrl(Uri.parse(widget.link));
                          } catch (e) {
                            throw 'could not launch url';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 34),
                          backgroundColor: CommonColors.secondaryGreenColor,
                        ),
                        child: const Text('Join',
                            style: TextStyle(color: CommonColors.whiteColor)),
                      ),
                      const SizedBox(
                          width: 8), // Add some spacing between the buttons
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: CommonColors.secondaryGreenColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
