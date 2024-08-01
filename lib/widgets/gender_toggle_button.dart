// import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';

// class GenderToggleButton extends StatefulWidget {
//   final String defaultValue;
//   final ValueChanged<String>? onChanged;

//   const GenderToggleButton({super.key, this.onChanged,required this.defaultValue});

//   @override
//   State<GenderToggleButton> createState() {
//     return _GenderToggleButtonState();
//   }
// }

// class _GenderToggleButtonState extends State<GenderToggleButton> {
//   late String _selectedGender; // Default value is 'male'

//   @override
//   void initState() {
//     super.initState();
//     if (widget.onChanged != null) {
//       widget.onChanged!(_selectedGender);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     _selectedGender = widget.defaultValue;
//     return SizedBox(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround, // Align text and buttons properly
//         children: <Widget>[
//           const Text(
//             "Gender",
//             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
//           ),
//           ToggleButtons(
//             fillColor: const Color.fromARGB(255, 240, 232, 245),
//             selectedColor: Colors.black,
//             borderRadius: BorderRadius.circular(10),
//             isSelected: [_selectedGender == 'male', _selectedGender == 'female'],
//             onPressed: (int index) {
//               setState(() {
//                 _selectedGender = index == 0 ? 'male' : 'female';
//                 if (widget.onChanged != null) {
//                   widget.onChanged!(_selectedGender);
//                 }
//               });
//             },
//             children:  [
//                Container(
                
//           margin: const EdgeInsets.symmetric(horizontal: 30.0),
//           child: const Column(
//             children: [ Icon(LineIcons.male), Text('Male')],
//           ),
//         ),
//                        Container(
//           margin: const EdgeInsets.symmetric(horizontal: 30.0),
//           child: const Column(
//             children: [  Icon(LineIcons.female), Text('Female')],
//           ),
//         ),
             
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:easypack/constants/constants_classes.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class GenderToggleButton extends StatefulWidget {
  final String defaultValue;
  final ValueChanged<String>? onChanged;

  const GenderToggleButton({super.key, this.onChanged, required this.defaultValue});

  @override
  State<GenderToggleButton> createState() {
    return _GenderToggleButtonState();
  }
}

class _GenderToggleButtonState extends State<GenderToggleButton> {
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.defaultValue; // Initialize _selectedGender
    if (widget.onChanged != null) {
      widget.onChanged!(_selectedGender);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Align text and buttons properly
        children: <Widget>[
          const Text(
            "Gender",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          ),
          ToggleButtons(
            fillColor: const Color.fromARGB(255, 240, 232, 245),
            selectedColor: Colors.black,
            borderRadius: BorderRadius.circular(10),
            isSelected: [_selectedGender == Gender.male, _selectedGender == Gender.female],
            onPressed: (int index) {
              setState(() {
                _selectedGender = index == 0 ? Gender.male : Gender.female;
                if (widget.onChanged != null) {
                  widget.onChanged!(_selectedGender);
                }
              });
            },
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Column(
                  children: [Icon(LineIcons.male), Text(Gender.male)],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Column(
                  children: [Icon(LineIcons.female), Text(Gender.female)],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
