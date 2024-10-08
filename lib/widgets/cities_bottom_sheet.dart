import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/widgets/auto_complete_field.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CitiesBottomSheet extends StatefulWidget {
  final String bottomSheetTitle;
  final String defaultValue;
  const CitiesBottomSheet({super.key,required this.bottomSheetTitle,required this.defaultValue});


  @override
  _CitiesBottomSheetState createState() => _CitiesBottomSheetState();
}


class _CitiesBottomSheetState extends State<CitiesBottomSheet> {
  void _showModalBottomSheet(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                     widget.bottomSheetTitle,
                      style:
                         const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AutoCompleteField(),
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showModalBottomSheet(context),
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color:Colors.grey[200]!,
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
              child: Consumer<AutoCompleteProvider>(
                builder: (context, autoCompleteProvider, child) {
                  return Text(
                    autoCompleteProvider.selectedCity?.text ?? widget.defaultValue,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
