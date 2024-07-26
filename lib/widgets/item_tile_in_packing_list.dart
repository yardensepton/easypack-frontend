// import 'package:flutter/material.dart';

// class ItemTileInPackingList extends StatelessWidget {
//   final bool isChecked;
//   final int amount;
//   final String name;

//   const ItemTileInPackingList({
//     super.key,
//     required this.isChecked,
//     required this.amount,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Checkbox(
//         value: isChecked,
//         onChanged: null, // Disable onChanged
//       ),
//       title: Row(
//         children: [
//           Text(
//             '$amount',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
//             ),
//           ),
//           const SizedBox(width: 10), // Add some space between amount and name
//           Text(
//             name,
//             style: TextStyle(
//               decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:flutter/material.dart';

class ItemTileInPackingList extends StatefulWidget {
  final bool initialPackedState;
  final int amount;
  final String name;
  final ValueChanged<bool?> onChanged;
  final PackingListProvider packingListProvider;
  // final Function()? onTap;

  const ItemTileInPackingList({
    super.key,
    required this.initialPackedState,
    required this.amount,
    required this.name,
    required this.onChanged,
    required this.packingListProvider
    // required this.onTap
  });

  @override
  _ItemTileInPackingListState createState() => _ItemTileInPackingListState();
}

class _ItemTileInPackingListState extends State<ItemTileInPackingList> {
  late bool isPacked;
  

  @override
  void initState() {
    super.initState();
    isPacked = widget.initialPackedState;
  }

  void _handleCheckboxChanged(bool? value) {
    setState(() {
      isPacked = value ?? false;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        activeColor: Colors.indigo[900],
        value: isPacked,
        onChanged: _handleCheckboxChanged,
        
      ),
      title: Row(
        children: [
          Text(
            '${widget.amount}',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              decoration: isPacked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          const SizedBox(width: 10), // Add some space between amount and name
          Text(
            widget.name,
            style: TextStyle(
              decoration: isPacked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ],
      ),
      // onTap: widget.onTap,
    );
  }
}
