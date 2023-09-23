import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../themes/palette.dart';
import '../pages/club_profile/club_profile_page.dart';

class MyCustomSearchBar extends StatefulWidget {
  final List<Map<String, dynamic>> suggestions;
  const MyCustomSearchBar({super.key, required this.suggestions});

  @override
  State<MyCustomSearchBar> createState() => _MyCustomSearchBarState();
}

class _MyCustomSearchBarState extends State<MyCustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          return widget.suggestions
              .where((map) => map['name']
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()))
              .map((map) => map['name']);
        }
      },
      onSelected: (String selectedValue) {
        final Map<String, dynamic> suggestion = widget.suggestions.firstWhere(
          (map) => map['name'] == selectedValue,
          orElse: () => <String, String>{},
        );
        final String email = suggestion['email'] ?? '';

        Route route = MaterialPageRoute(
          builder: (context) =>
              ClubProfilePage(email: email, isTitleCenter: true),
        );
        Navigator.push(context, route);
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.circular(12),
            elevation: 4,
            color: CommonColors.secondaryGreenColor,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.87,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  final Map<String, dynamic> suggestion =
                      widget.suggestions.firstWhere(
                    (map) => map['name'] == option,
                    orElse: () => <String, String>{},
                  );
                  final String profileImageUrl =
                      suggestion['profileImageURL'] ?? '';

                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      tileColor: CommonColors.secondaryGreenColor,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                      title: Text(
                        option,
                        style: const TextStyle(
                          color: CommonColors.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          style: Theme.of(context).textTheme.displayMedium,
          cursorColor: CommonColors.secondaryGreenColor,
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            border: Theme.of(context).inputDecorationTheme.border,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            fillColor: Theme.of(context).dialogBackgroundColor,
            hintText: 'Search for clubs and students...',
            hintStyle: Theme.of(context).textTheme.displayMedium,
            prefixIcon: Icon(
              PhosphorIcons.light.magnifyingGlass,
              color: PaletteDarkMode.secondaryTextColor,
            ),
          ),
        );
      },
    );
  }
}
