import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/themes/palette.dart';

class CustomSearchBar extends StatefulWidget {
  final String hint;
  final Color? iconColor;
  final ValueChanged<String>? onSearchSubmitted;

  const CustomSearchBar({
    Key? key,
    required this.hint,
    this.iconColor = PaletteLightMode.secondaryTextColor,
    this.onSearchSubmitted,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late FocusNode _focusNode;
  Color? _currentIconColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _currentIconColor = widget.iconColor;
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _currentIconColor = _focusNode.hasFocus
          ? CommonColors.secondaryGreenColor
          : widget.iconColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: CommonColors.shadowColor,
            offset: Offset(8, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          hoverColor: CommonColors.transparentColor,
        ),
        child: TextField(
          onSubmitted: widget.onSearchSubmitted,
          style: Theme.of(context).textTheme.displayMedium,
          cursorColor: CommonColors.secondaryGreenColor,
          focusNode: _focusNode,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).dialogBackgroundColor,
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.displayMedium,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 27),
              child: Icon(PhosphorIcons.light.magnifyingGlass,
                  color: _currentIconColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: CommonColors.transparentColor, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: CommonColors.secondaryGreenColor, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
