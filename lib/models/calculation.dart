class Calculation {
  String? id;
  String category;
  double amountPerDay;
  bool activity;

  Calculation({
    this.id,
    required this.category,
    required this.amountPerDay,
    required this.activity,
  });

  factory Calculation.fromJson(Map<String, dynamic> json) {
    return Calculation(
        id: json['id'],
        category: json['category'],
        amountPerDay: json['amount_per_day'],
        activity: json['activity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount_per_day': amountPerDay,
      'activity': activity
    };
  }
}
