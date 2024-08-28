import 'package:easypack/constants/constants_classes.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class TripTypeToggleButton extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const TripTypeToggleButton({super.key, this.onChanged});

  @override
  State<TripTypeToggleButton> createState() {
    return _TripTypeToggleButtonState();
  }
}

class _TripTypeToggleButtonState extends State<TripTypeToggleButton> {
  String _selectedTripType = TripType.pleasure; // Default value is 'pleasure'

  @override
  void initState() {
    super.initState();
    if (widget.onChanged != null) {
      widget.onChanged!(_selectedTripType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select your trip type",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align text and buttons properly
            children: <Widget>[
              ToggleButtons(
                fillColor: Colors.grey[300]!,
                selectedColor: Colors.black,
                borderRadius: BorderRadius.circular(10),
                isSelected: [
                  _selectedTripType == TripType.business,
                  _selectedTripType == TripType.pleasure
                ],
                onPressed: (int index) {
                  setState(() {
                    _selectedTripType =
                        index == 0 ? TripType.business : TripType.pleasure;
                    if (widget.onChanged != null) {
                      widget.onChanged!(_selectedTripType);
                    }
                  });
                },
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: const Column(
                      children: [
                        Icon(LineIcons.businessTime),
                        Text(TripType.business)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: const Column(
                      children: [
                        Icon(LineIcons.glassCheers),
                        Text(TripType.pleasure)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
