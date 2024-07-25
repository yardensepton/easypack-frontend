import 'package:easypack/widgets/number_picker.dart';
import 'package:flutter/material.dart';

class AddItemBottomSheet extends StatefulWidget {
  final String tripId;

  const AddItemBottomSheet({super.key, required this.tripId});

  @override
  _AddItemBottomSheetState createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
    int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
                  NumberPicker(
                    minValue: 1,
                    maxValue: 100,
                    initialValue: amount,
                    onChanged: (value) {
                      setState(() {
                        amount = value;
                      });
                    },
                  ),
              ElevatedButton(
                onPressed: () {
                  final category = categoryController.text;
                  final name = nameController.text;
                  final intValue = amount;

                  print('Category: $category');
                  print('Name: $name');
                  print('Integer Value: $intValue');

                  // Add your logic to save the item

                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
