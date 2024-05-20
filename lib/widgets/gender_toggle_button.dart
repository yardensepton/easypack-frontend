import 'package:flutter/material.dart';

class GenderToggleButton extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const GenderToggleButton({super.key, this.onChanged});


  @override
  State<GenderToggleButton> createState() {
    return _GenderToggleButtonState();
  }
}


class _GenderToggleButtonState extends State<GenderToggleButton> {
  String _selectedGender = '';
    List<bool> isSelected = [true, false]; 


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        const Text("Choose your gender",
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal)),
          ToggleButtons(
            
            
        isSelected: [_selectedGender == 'male', _selectedGender == 'female'],
        onPressed: (int index) {
          setState(() {
            _selectedGender = index == 0 ? 'male' : 'female';
            if (widget.onChanged != null) {
              widget.onChanged!(_selectedGender);
            }
          });
        },
        children: const [
          Icon(Icons.man),
          Icon(Icons.woman),
        ],
      )
      ]),
    );
  
  }
}
