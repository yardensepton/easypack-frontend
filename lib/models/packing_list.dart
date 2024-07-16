import 'package:easypack/models/item_list.dart';

class PackingList{
final String? id;
final String tripId;
final List<ItemList> items;


PackingList({
  this.id,
  required this.tripId,
  required this.items,
});


  factory PackingList.fromJson(Map<String, dynamic> json) {
    List<ItemList> allItems = [];
    if (json['items'] != null) {
      allItems = (json['items'] as List)
          .map((item) => ItemList.fromJson(item))
          .toList();
    }

    return PackingList(
      id: json['id'],
      tripId: json['trip_id'],
      items: allItems,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> allItems = items.map((item) => item.toJson()).toList();;

    return {
      'id': id,
      'trip_id': tripId,
      'items': allItems,
    };
  }


}