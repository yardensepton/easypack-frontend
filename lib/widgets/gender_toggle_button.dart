import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class GenderToggleButton extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const GenderToggleButton({super.key, this.onChanged});

  @override
  State<GenderToggleButton> createState() {
    return _GenderToggleButtonState();
  }
}

class _GenderToggleButtonState extends State<GenderToggleButton> {
  String _selectedGender = 'male'; // Default value is 'male'

  @override
  void initState() {
    super.initState();
    // Trigger the onChanged function with the default value when the widget is first built
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
            isSelected: [_selectedGender == 'male', _selectedGender == 'female'],
            onPressed: (int index) {
              setState(() {
                _selectedGender = index == 0 ? 'male' : 'female';
                if (widget.onChanged != null) {
                  widget.onChanged!(_selectedGender);
                }
              });
            },
            children:  [
               Container(
                
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          child: const Column(
            children: [ Icon(LineIcons.male), Text('Male')],
          ),
        ),
                       Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          child: const Column(
            children: [  Icon(LineIcons.female), Text('Female')],
          ),
        ),
             
            ],
          )
        ],
      ),
    );
  }
}
