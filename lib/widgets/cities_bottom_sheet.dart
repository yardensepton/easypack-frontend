import 'package:easypack/widgets/auto_complete_field.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CitiesBottomSheet extends StatefulWidget {
  const CitiesBottomSheet({super.key});

  @override
  _CitiesBottomSheetState createState() => _CitiesBottomSheetState();
}
class _CitiesBottomSheetState extends State<CitiesBottomSheet>{

    String _selectedCity = 'Residence';

    void _showModalBottomSheet(BuildContext context) {
    
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 500,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AutoCompleteField(onCitySelected: (String value) { 
                  setState(() {
                      _selectedCity = value;
                    });
                    Navigator.of(context).pop();
                  
                 },),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     width: 350,
  //     padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(255, 240, 232, 245),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: GestureDetector(
  //       onTap: () => _showModalBottomSheet(context),
  //       child: Row(
  //         children: [
  //           Icon(
  //             LineIcons.city,
  //             color: Colors.grey[700],
  //           ),
  //           const SizedBox(width: 10),
  //            Text(
  //             _selectedCity,
  //             style: const TextStyle(
  //               fontWeight: FontWeight.normal,
  //               fontSize: 16,
  //               color: Color.fromARGB(255, 100, 99, 99),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => _showModalBottomSheet(context),
    child: Container(
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 232, 245),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            LineIcons.city,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _selectedCity,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Color.fromARGB(255, 100, 99, 99),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}



  