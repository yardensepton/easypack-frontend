import 'package:easypack/models/item_list.dart';
import 'package:flutter/material.dart';

class TripItemsGroupedByCategory extends StatelessWidget {
  final List<ItemList> items;

  const TripItemsGroupedByCategory({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    Map<String, List<ItemList>> groupedItems = groupItemsByCategory(items);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedItems.entries.map((entry) {
        String category = entry.key;
        List<ItemList> categoryItems = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                category,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categoryItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: Text('${item.itemName} - Amount per trip: ${item.amountPerTrip}'),
                );
              }).toList(),
            ),
            const Divider(),
          ],
        );
      }).toList(),
    );
  }

  Map<String, List<ItemList>> groupItemsByCategory(List<ItemList> items) {
    Map<String, List<ItemList>> groupedItems = {};

    for (var item in items) {
      String category = item.category;
      if (!groupedItems.containsKey(category)) {
        groupedItems[category] = [];
      }
      groupedItems[category]!.add(item);
    }

    return groupedItems;
  }
}
