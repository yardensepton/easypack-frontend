class ItemList{

  final String itemName;
final String category;
final int amountPerTrip;

ItemList({
  required this.itemName,
  required this.category,
  required this.amountPerTrip,
});

  factory ItemList.fromJson(Map<String, dynamic> json) {
    return ItemList(
      itemName: json['item_name'],
      category: json['category'],
      amountPerTrip: json['amount_per_trip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': itemName,
      'category': category,
      'amount_per_trip': amountPerTrip,
    };
  }

  
}