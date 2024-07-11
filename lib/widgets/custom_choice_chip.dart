// import 'package:flutter/material.dart';

// class CustomChoiceChip extends StatefulWidget {
//   const CustomChoiceChip({super.key});

//   @override
//   _CustomChoiceChipState createState() => _CustomChoiceChipState();
// }

// class _CustomChoiceChipState extends State<CustomChoiceChip> {
//   final List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
//   Set<String> selectedOptions = {};

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topLeft,
//       child: SingleChildScrollView(
//         child: Wrap(
//           spacing: 6.0,
//           runSpacing: 6.0,
//           children: options.map((option) {
//             return Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: ChoiceChip(
//                 label: Text(option),
//                 labelStyle: const TextStyle(
//                   fontSize: 13, 
//                   fontWeight: FontWeight.normal,
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), 
//                 selected: selectedOptions.contains(option),
//                 onSelected: (isSelected) {
//                   setState(() {
//                     if (isSelected) {
//                       selectedOptions.add(option);
//                     } else {
//                       selectedOptions.remove(option);
//                     }
//                   });
//                 },
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  final List<String> options;

  const CustomChoiceChip({super.key, required this.options});

  @override
  _CustomChoiceChipState createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  Set<String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: widget.options.map((option) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ChoiceChip(
                label: Text(option),
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
