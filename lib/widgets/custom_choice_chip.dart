import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  const CustomChoiceChip({super.key});

  @override
  _CustomChoiceChipState createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  final List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  Set<String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          mainAxisSpacing: 4.0, // Adjust the main axis (vertical) spacing
          crossAxisSpacing: 4.0, // Adjust the cross axis (horizontal) spacing
          childAspectRatio: 3.5, // Adjust to make the chips wider and reduce height
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return ChoiceChip(
            label: Text(option),
            labelStyle: const TextStyle(
              fontSize: 13, // Adjust the font size as needed
              fontWeight: FontWeight.normal,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust the padding as needed
            selected: selectedOptions.contains(option),
            onSelected: (isSelected) {
              setState(() {
                if (isSelected) {
                  selectedOptions.add(option);
                } else {
                  selectedOptions.remove(option);
                }
              });
            },
          );
        },
      ),
    );
  }
}
