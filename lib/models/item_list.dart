class ItemList {
  final String itemName;
  final String category;
  int amountPerTrip;
  bool isPacked;

  ItemList(
      {required this.itemName,
      required this.category,
      required this.amountPerTrip,
      required this.isPacked});

  factory ItemList.fromJson(Map<String, dynamic> json) {
    return ItemList(
        itemName: json['item_name'],
        category: json['category'],
        amountPerTrip: json['amount_per_trip'],
        isPacked: json['is_packed']);
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': itemName,
      'category': category,
      'amount_per_trip': amountPerTrip,
      'is_packed': isPacked
    };
  }
}
