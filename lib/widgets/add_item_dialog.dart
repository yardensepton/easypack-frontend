// import 'package:easypack/enums/enum_actions.dart';
// import 'package:easypack/models/item_list.dart';
// import 'package:easypack/providers/packing_list_provider.dart';
// import 'package:easypack/utils/validators.dart';
// import 'package:easypack/widgets/number_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AddItemDialog extends StatefulWidget {
//   final String tripId;
//   const AddItemDialog({super.key, required this.tripId});

//   @override
//   _AddItemDialogState createState() => _AddItemDialogState();
// }

// class _AddItemDialogState extends State<AddItemDialog> {
//   final TextEditingController itemNameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   int amount = 1;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       title: const Text('Add an item'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: categoryController,
//                 decoration: InputDecoration(
//                   labelText: 'Category',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide:
//                         const BorderSide(color: Colors.blue, width: 2.0),
//                   ),
//                 ),
//                 validator: (value) =>
//                     Validators.validateNotEmpty(value, "Category"),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: itemNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Item Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide:
//                         const BorderSide(color: Colors.blue, width: 2.0),
//                   ),
//                 ),
//                 validator: (value) =>
//                     Validators.validateNotEmpty(value, "Item name"),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Amount per Trip',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   NumberPicker(
//                     minValue: 1,
//                     maxValue: 100,
//                     initialValue: amount,
//                     onChanged: (value) {
//                       setState(() {
//                         amount = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Cancel', style: TextStyle(color: Colors.red)),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               String itemName = itemNameController.text;
//               String category = categoryController.text;
//               addNewItem(context, widget.tripId, itemName, category, amount);
//               Navigator.of(context).pop();
//             }
//           },
//           child: const Text('Add'),
//         ),
//       ],
//     );
//   }
// }

// Future<void> addNewItem(BuildContext context, String tripId, String itemName,
//     String category, int amount) async {
//   ItemList details =
//       ItemList(itemName: itemName, category: category, amountPerTrip: amount);
//   await Provider.of<PackingListProvider>(context, listen: false)
//       .updatePackingList(tripId, EnumActions.add, details);
// }
import 'package:easypack/enums/enum_actions.dart';
import 'package:easypack/models/item_list.dart';
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/utils/validators.dart';
import 'package:easypack/widgets/number_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItemDialog extends StatefulWidget {
  final String tripId;
  const AddItemDialog({super.key, required this.tripId});

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text('Add an item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: (value) =>
                  Validators.validateNotEmpty(value, "Category"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: itemNameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: (value) =>
                  Validators.validateNotEmpty(value, "Item name"),
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
            if (_formKey.currentState!.validate()) {
              String itemName = itemNameController.text;
              String category = categoryController.text;
              addNewItem(context, widget.tripId, itemName, category, amount);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

Future<void> addNewItem(BuildContext context, String tripId, String itemName,
    String category, int amount) async {
  ItemList details =
      ItemList(itemName: itemName, category: category, amountPerTrip: amount);
  await Provider.of<PackingListProvider>(context, listen: false)
      .updatePackingList(tripId, EnumActions.add, details);
}
