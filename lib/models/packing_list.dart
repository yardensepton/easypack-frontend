import 'package:easypack/models/item_list.dart';

class PackingList{
final String? id;
final String tripId;
final String? description;
final List<ItemList> items;
final int homeAverageTemp;
final int tripAverageTemp;


PackingList({
  this.id,
  required this.tripId,
  required this.items,
  this.description,
  required this.homeAverageTemp,
  required this.tripAverageTemp,
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
      description: json['description'],
      tripId: json['trip_id'],
      items: allItems,
      homeAverageTemp: json['home_average_temp'],
      tripAverageTemp: json['trip_average_temp'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> allItems = items.map((item) => item.toJson()).toList();

    return {
      'id': id,
      'description':description,
      'trip_id': tripId,
      'items': allItems,
      'home_average_temp': homeAverageTemp,
      'trip_average_temp': tripAverageTemp,
    };
  }


}