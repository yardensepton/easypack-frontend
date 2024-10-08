import 'package:easypack/utils/string_extentsion.dart';
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  final List<String> options;
  final String title;
  final Function(String) addSelection;
  final Function(String) removeSelection;

  const CustomChoiceChip({
    super.key,
    required this.options,
    required this.title,
    required this.addSelection,
    required this.removeSelection,
  });

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 15.0, // Spacing between columns
            mainAxisSpacing: 10.0, // Spacing between rows
            childAspectRatio: 3,
          ),
          itemCount: widget.options.length,
          itemBuilder: (BuildContext context, int index) {
            String option = widget.options[index].capitalize();
            return GestureDetector(
              child: Container(
                alignment: Alignment.topLeft, // Align chips to the start
                child: ChoiceChip(
                   side: BorderSide(
                  color:  Colors.grey, // Border color changes based on selection
                  width: 1.5, // Border width
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                  selectedColor: Colors.grey[300]!,
                  backgroundColor: Colors.grey[100]!,
                  label: Text(option),
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 8.0),
                  selected: selectedOptions.contains(option),
                  onSelected: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        selectedOptions.add(option);
                        widget.addSelection(option);
                      } else {
                        selectedOptions.remove(option);
                        widget.removeSelection(option);
                      }
                    });
                    
                  },
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
