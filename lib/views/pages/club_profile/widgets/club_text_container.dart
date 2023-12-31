import 'package:flutter/material.dart';
import 'package:scholarsync/themes/palette.dart';
import 'package:expandable_text/expandable_text.dart';

class CustomTextContainer extends StatefulWidget {
  final String heading;
  final String text;
  final double headingSize;
  final Color backgroundColor;
  final double borderRadius;
  final double padding;

  const CustomTextContainer({
    Key? key,
    required this.heading,
    required this.text,
    this.headingSize = 16.0,
    this.backgroundColor = CommonColors.whiteColor,
    this.borderRadius = 10.0,
    this.padding = 20.0,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextContainerState createState() => _CustomTextContainerState();
}

class _CustomTextContainerState extends State<CustomTextContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: const [
          BoxShadow(
            color: CommonColors.shadowColor,
            offset: Offset(8, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: EdgeInsets.only(
          top: 15,
          left: widget.padding,
          bottom: widget.padding,
          right: widget.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.heading,
            style: TextStyle(
              fontSize: widget.headingSize,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          const SizedBox(height: 10),
          ExpandableText(
            widget.text,
            expandText: 'Read More',
            collapseText: 'Read Less',
            animation: true,
            maxLines: 3,
            linkColor: PaletteLightMode.secondaryTextColor,
            linkStyle: const TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),
            style: Theme.of(context).textTheme.labelSmall,
            expanded: isExpanded,
          ),
        ],
      ),
    );
  }
}
