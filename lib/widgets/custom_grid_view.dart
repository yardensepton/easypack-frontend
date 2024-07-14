import 'package:easypack/utils/string_extentsion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomGridView extends StatefulWidget {
  final List<String> activities;
  final String title;

  const CustomGridView({
    super.key,
    required this.activities,
    required this.title,
  });

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  Set<String> selectedOptions = {}; // State for tracking selected options

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
          physics: const NeverScrollableScrollPhysics(), // Prevent scrolling within the grid
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
                  } else {
                    selectedOptions.add(option);
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey.withOpacity(0.3) : Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: isSelected ? Colors.grey : Colors.grey,
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
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 4), // Space between the icon and text
                    Text(
                      option.removeUnderscores(),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
