import 'package:easypack/widgets/number_picker.dart';
import 'package:flutter/material.dart';

// class AddItemDialog extends StatelessWidget {
//   final TextEditingController itemNameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();

//   AddItemDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       title: const Text('Add an Item'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: itemNameController,
//               decoration: InputDecoration(
//                 labelText: 'Item Name',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: categoryController,
//               decoration: InputDecoration(
//                 labelText: 'Category',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: amountController,
//                keyboardType: const TextInputType.numberWithOptions(decimal: true),
//               // keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Amount per Trip',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             // Handle the submission logic here
//             // You can access the inputs using the controllers
//             String itemName = itemNameController.text;
//             String category = categoryController.text;
//             String amount = amountController.text;

//             // Example: print the values
//             print('Item Name: $itemName');
//             print('Category: $category');
//             print('Amount per Trip: $amount');

//             Navigator.of(context).pop();
//           },
//           child: const Text('Add'),
//         ),
//       ],
//     );
//   }
// }
class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text('Add an item'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Amount per Trip',
                  style: TextStyle(fontSize: 16),
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
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle the submission logic here
            String itemName = itemNameController.text;
            String category = categoryController.text;

            // Example: print the values
            print('Item Name: $itemName');
            print('Category: $category');
            print('Amount per Trip: $amount');

            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
