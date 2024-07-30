import 'package:easypack/providers/packing_list_provider.dart';
import 'package:flutter/material.dart';
import 'number_picker.dart'; 

class ItemTileInPackingList extends StatefulWidget {
  final bool initialPackedState;
  final int amount;
  final String name;
  final ValueChanged<bool?> onChanged;
  final PackingListProvider packingListProvider;
  final ValueChanged<int> onLongPress;

  const ItemTileInPackingList({
    super.key,
    required this.initialPackedState,
    required this.amount,
    required this.name,
    required this.onChanged,
    required this.packingListProvider,
    required this.onLongPress,
  });

  @override
  _ItemTileInPackingListState createState() => _ItemTileInPackingListState();
}

class _ItemTileInPackingListState extends State<ItemTileInPackingList> {
  late bool isPacked;
  late int currentAmount;
  bool showNumberPicker = false;

  @override
  void initState() {
    super.initState();
    isPacked = widget.initialPackedState;
    currentAmount = widget.amount;
  }

  void _handleCheckboxChanged(bool? value) {
    setState(() {
      isPacked = value ?? false;
    });
    widget.onChanged(value);
  }

  void _toggleNumberPicker() {
    setState(() {
      showNumberPicker = !showNumberPicker;
    });
  }

  void _handleAmountChanged(int value) {
    setState(() {
      currentAmount = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onLongPress(currentAmount);
        _toggleNumberPicker();
      },
      child: ListTile(
        trailing: Checkbox(
          activeColor: Colors.indigo[900],
          value: isPacked,
          onChanged: _handleCheckboxChanged,
        ),
        title: Row(
          children: [
            if (showNumberPicker)
              NumberPicker(
                minValue: 1,
                maxValue: 10,
                initialValue: currentAmount,
                onChanged: _handleAmountChanged,
              )
            else
              Text(
                '$currentAmount',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  decoration: isPacked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(
                  overflow: showNumberPicker ? TextOverflow.ellipsis : TextOverflow.visible,
                  decoration: isPacked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
