import 'package:easypack/utils/string_extentsion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconsGridView extends StatefulWidget {
  final List<String> activities;
  final String title;
  final Function(String) addSelection;
  final Function(String) removeSelection;

  const CustomIconsGridView({
    super.key,
    required this.activities,
    required this.title,
    required this.addSelection,
    required this.removeSelection,
  });

  @override
  State<CustomIconsGridView> createState() => _CustomIconsGridViewState();
}

class _CustomIconsGridViewState extends State<CustomIconsGridView> {
  Set<String> selectedOptions = {};
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 10,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // Prevent scrolling within the grid
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 15.0, // Spacing between columns
            mainAxisSpacing: 5.0, // Spacing between rows
            childAspectRatio: 1, // Make each item square
          ),
          itemCount: widget.activities.length,
          itemBuilder: (BuildContext context, int index) {
            String option = widget.activities[index].capitalize();
            bool isSelected = selectedOptions.contains(option);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedOptions.remove(option);
                    print("removes $option");
                    widget.removeSelection(option);
                  } else {
                    print("adds $option");
                    selectedOptions.add(option);
                    widget.addSelection(option);
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      isSelected ?  Colors.grey[300]! : Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/${option.toLowerCase()}.svg",
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                        height: 4), // Space between the icon and text
                    Text(
                      option.removeUnderscores(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
                  const SizedBox(
            height: 20,
          ),
      ],
    );
  }
}
